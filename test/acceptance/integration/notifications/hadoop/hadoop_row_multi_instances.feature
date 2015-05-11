# -*- coding: utf-8 -*-
#
# Copyright 2015 Telefonica Investigación y Desarrollo, S.A.U
#
# This file is part of fiware-cygnus (FI-WARE project).
#
# fiware-cygnus is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General
# Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any
# later version.
# fiware-cygnus is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along with fiware-cygnus. If not, see
# http://www.gnu.org/licenses/.
#
# For those usages not covered by the GNU Affero General Public License please contact:
# iot_support at tid.es
#
__author__ = 'Iván Arias León (ivan.ariasleon at telefonica dot com)'
#
#  Note: the "skip" tag is to skip the scenarios that still are not developed or failed
#        -tg=-skip
#


Feature: start multi-instances of cygnus using hadoop sink and row mode
  As a cygnus user
  I want to be able to start multi-instances of cygnus using hadoop sink and row mode
  so that they become more functional and useful

  @happy_path @multi_instances
  Scenario Outline: start multi-instances of cygnus using hadoop sink, row mode, ports differents and store multiples notifications one by instance and the port defined incremented
    Given copy properties.json file from "filab_properties.json" to test "hdfs-sink" and sudo local "false"
    And configuration of cygnus instances with different ports "true", agents files quantity "<instances_number>", id "test" and in "row" mode
    And copy flume-env.sh, matching table file from "matching_table.conf", log4j.properties, krb5.conf and restart cygnus service. This execution is only once "false"
    And verify if cygnus is installed correctly
    And "hadoop" is installed correctly
    And a tenant "cygnus_multi_instance_01", service path "/test", resource "room2_room", with attribute number "1", attribute name "attribute" and attribute type "celcius"
    When receives multiples notifications one by instance and the port defined incremented with attributes value "<attribute_value>", metadata value "<metadata_value>" and content "<content>"
    Then Validate that the attribute value and type are stored in hadoop
    And Validate that the attribute metadatas are stored in hadoop
    And delete the file created in hadoop
    And delete instances files
  Examples:
    | instances_number | attribute_value | metadata_value | content |
    | 1                | 40.0            | True           | json    |
    | 1                | 41.1            | False          | json    |
    | 1                | 42.2            | True           | xml     |
    | 1                | 43.3            | false          | xml     |
    | 5                | 44.4            | True           | json    |
    | 5                | 45.5            | False          | json    |
    | 5                | 46.6            | True           | xml     |
    | 5                | 47.7            | false          | xml     |
    | 10               | 48.8            | True           | json    |
    | 10               | 49.9            | False          | json    |
    | 10               | 50.0            | True           | xml     |
    | 10               | 51.1            | false          | xml     |

  @same_port @multi_instances @ISSUE_46
  Scenario Outline: start multi-instances of cygnus using hadoop sink, row mode, ports differents and store multiples notifications one by instance and the port defined incremented
    Given copy properties.json file from "filab_properties.json" to test "hdfs-sink" and sudo local "false"
    And configuration of cygnus instances with different ports "false", agents files quantity "<instances_number>", id "test" and in "row" mode
    And copy flume-env.sh, matching table file from "matching_table.conf", log4j.properties, krb5.conf and restart cygnus service. This execution is only once "false"
    And verify if cygnus is installed correctly
    And "hadoop" is installed correctly
    And a tenant "cygnus_multi_instance_02", service path "/test", resource "room2_room", with attribute number "1", attribute name "attribute" and attribute type "celcius"
    When receives multiples notifications one by instance and the port defined incremented with attributes value "<attribute_value>", metadata value "<metadata_value>" and content "<content>"
    Then Validate that the attribute value and type are stored in hadoop
    And Validate that the attribute metadatas are stored in hadoop
    And delete the file created in hadoop
    And delete instances files
  Examples:
    | instances_number | attribute_value | metadata_value | content |
    | 2                | 40.0            | True           | json    |
    | 2                | 41.1            | False          | json    |
    | 2                | 42.2            | True           | xml     |
    | 2                | 43.3            | false          | xml     |
    | 5                | 44.4            | True           | json    |
    | 5                | 45.5            | False          | json    |
    | 5                | 46.6            | True           | xml     |
    | 5                | 47.7            | false          | xml     |
   