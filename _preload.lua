--
-- Copyright (c) 2019 Aldo Nicolas Bruno
--
-- Based on codelite premake plugin:--
-- Name:        cmake/_preload.lua
-- Purpose:     Define the cmake action.
-- Author:      Ryan Pusztai
-- Modified by: Andrea Zanellato
--              Andrew Gough
--              Manu Evans
-- Created:     2013/05/06
-- Copyright:   (c) 2008-2015 Jason Perkins and the Premake project
-- 
--
-- Decide when the full module should be loaded.
--

	return function(cfg)
		return (_ACTION == "cmake")
	end
