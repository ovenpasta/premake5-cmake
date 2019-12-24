--
-- Copyright (c) 2019 Aldo Nicolas Bruno
--
-- Based on codelite premake plugin:--
-- Name:        cmake/cmake.lua
-- Purpose:     Define the cmake action(s).
-- Author:      Ryan Pusztai
-- Modified by: Andrea Zanellato
--              Andrew Gough
--              Manu Evans
-- Created:     2013/05/06
-- Copyright:   (c) 2008-2015 Jason Perkins and the Premake project
--

	local p = premake

	p.modules.cmake = {}
	p.modules.cmake._VERSION = p._VERSION

	local cmake = p.modules.cmake
	local project = p.project

	newaction
	{
		-- Metadata for the command line and help system

		trigger         = "cmake",
		shortname       = "cmake",
		description     = "Generate cmake project files",
		toolset         = "clang",

		-- The capabilities of this action

		valid_kinds     = { "ConsoleApp", "WindowedApp", "Makefile", "SharedLib", "StaticLib", "Utility" },
		valid_languages = { "C", "C++" },
		valid_tools     = {
			cc = { "gcc", "clang", "msc" }
		},

		-- Workspace and project generation logic

		onWorkspace = function(wks)
			p.modules.cmake.generateWorkspace(wks)
		end,
		onProject = function(prj)
			p.modules.cmake.generateProject(prj)
		end,

		onCleanWorkspace = function(wks)
			p.modules.cmake.cleanWorkspace(wks)
		end,
		onCleanProject = function(prj)
			p.modules.cmake.cleanProject(prj)
		end,
		onCleanTarget = function(prj)
			p.modules.cmake.cleanTarget(prj)
		end,
	}

	function cmake.cfgname(cfg)
		local cfgname = cfg.buildcfg
		if cmake.workspace.multiplePlatforms then
			cfgname = string.format("%s|%s", cfg.platform, cfg.buildcfg)
		end
		return cfgname
	end

	-- Element text is not escaped the same as element attributes
	function cmake.escElementText(value)
		local result = value:gsub('&', '&amp;')
		result = result:gsub('<', '&lt;')
		result = result:gsub('>', '&gt;')
		return result
	end

	function cmake.esc(value)
		local result = value:gsub('&', '&amp;')
		result = result:gsub('<', '&lt;')
		result = result:gsub('>', '&gt;')
		result = result:gsub('"', '\\&quot;')
		return result
	end

	function cmake.wksdir(wks)
		return wks.location .. "/" .. wks.name .. "/"
	end

	function cmake.generateWorkspace(wks)
		p.eol("\r\n")
		p.indent("  ")
		p.escaper(cmake.esc)
		os.mkdir(wks.location .. "/" .. wks.name)
		p.generate(wks, cmake.wksdir(wks) .. "/CMakeLists.txt", cmake.workspace.generate)
	end

	function cmake.generateProject(prj)
		p.eol("\r\n")
		p.indent("  ")
		p.escaper(cmake.esc) 
		if project.isc(prj) or project.iscpp(prj) then
			for cfgname in project.eachconfig(prj) do
				p.generate(prj, cmake.wksdir(prj.workspace) .. prj.name ..  ".cmake", cmake.project.generate)
			end
		end
	end

	function cmake.cleanWorkspace(wks)
		p.clean.file(wks, "CMakeLists.txt")
	end

	function cmake.cleanProject(prj)
		p.clean.file(prj, prj.name .. ".cmake")
	end

	function cmake.cleanTarget(prj)
		-- TODO..
	end

	include("cmake_workspace.lua")
	include("cmake_project.lua")

	return cmake
