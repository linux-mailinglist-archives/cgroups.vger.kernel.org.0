Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AEA2C3F4C
	for <lists+cgroups@lfdr.de>; Wed, 25 Nov 2020 12:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgKYLsi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 25 Nov 2020 06:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgKYLsi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 25 Nov 2020 06:48:38 -0500
X-Greylist: delayed 512 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 25 Nov 2020 03:48:38 PST
Received: from smtprelay.restena.lu (smtprelay.restena.lu [IPv6:2001:a18:1::62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E67C0613D4
        for <cgroups@vger.kernel.org>; Wed, 25 Nov 2020 03:48:38 -0800 (PST)
Received: from hemera (unknown [IPv6:2001:a18:1:10:fa75:a4ff:fe28:fe3a])
        by smtprelay.restena.lu (Postfix) with ESMTPS id F32F640FFF;
        Wed, 25 Nov 2020 12:39:56 +0100 (CET)
Date:   Wed, 25 Nov 2020 12:39:56 +0100
From:   Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Chris Down <chris@chrisdown.name>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Regression from 5.7.17 to 5.9.9 with memory.low cgroup constraints
Message-ID: <20201125123956.61d9e16a@hemera>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On a production system I've encountered a rather harsh behavior from
kernel in the context of memory cgroup (v2) after updating kernel from
5.7 series to 5.9 series.


It seems like kernel is reclaiming file cache but leaving inode cache
(reclaimable slabs) alone in a way that the server ends up trashing and
maxing out on IO to one of its disks instead of doing actual work.


My setup, server has 64G of RAM:
  root
   + system        { min=0, low=128M, high=8G, max=8G }
     + base        { no specific constraints }
     + backup      { min=0, low=32M, high=2G, max=2G }
     + shell       { no specific constraints }
  + websrv         { min=0, low=4G, high=32G, max=32G }
  + website        { min=0, low=16G, high=40T, max=40T }
    + website1     { min=0, low=64M, high=2G, max=2G }
    + website2     { min=0, low=64M, high=2G, max=2G }
      ...
  + remote         { min=0, low=1G, high=14G, max=14G }
    + webuser1     { min=0, low=64M, high=2G, max=2G }
    + webuser2     { min=0, low=64M, high=2G, max=2G }
      ...


When the server was struggling I've had mostly IO on disk hosting
system processes and some cache files of websrv processes.
It seems that running backup does make the issue much more probable.

The processes in websrv are the most impacted by the trashing and this
is the one with lots of disk cache and inode cache assigned to it.
(note a helper running in websrv cgroup scan whole file system
hierarchy once per hour and this keeps inode cache pretty filled.
Dropping just file cache (about 10G) did not unlock situation but
dropping reclaimable slabs (inode cache, about 30G) got the system back
running.



Some metrics I have collected during a trashing period (metrics
collected at about 5min interval) - I don't have ful memory.stat
unfortunately:

system/memory.min              0              = 0
system/memory.low              134217728      = 134217728
system/memory.high             8589934592     = 8589934592
system/memory.max              8589934592     = 8589934592
system/memory.pressure
    some avg10=54.41 avg60=59.28 avg300=69.46 total=7347640237
    full avg10=27.45 avg60=22.19 avg300=29.28 total=3287847481
  ->
    some avg10=77.25 avg60=73.24 avg300=69.63 total=7619662740
    full avg10=23.04 avg60=25.26 avg300=27.97 total=3401421903
system/memory.current          262533120      < 263929856
system/memory.events.local
    low                        5399469        = 5399469
    high                       0              = 0
    max                        112303         = 112303
    oom                        0              = 0
    oom_kill                   0              = 0

system/base/memory.min         0              = 0
system/base/memory.low         0              = 0
system/base/memory.high        max            = max
system/base/memory.max         max            = max
system/base/memory.pressure
    some avg10=18.89 avg60=20.34 avg300=24.95 total=5156816349
    full avg10=10.90 avg60=8.50 avg300=11.68 total=2253916169
  ->
    some avg10=33.82 avg60=32.26 avg300=26.95 total=5258381824
    full avg10=12.51 avg60=13.01 avg300=12.05 total=2301375471
system/base/memory.current     31363072       < 32243712
system/base/memory.events.local
    low                        0              = 0
    high                       0              = 0
    max                        0              = 0
    oom                        0              = 0
    oom_kill                   0              = 0

system/backup/memory.min       0              = 0
system/backup/memory.low       33554432       = 33554432
system/backup/memory.high      2147483648     = 2147483648
system/backup/memory.max       2147483648     = 2147483648
system/backup/memory.pressure
    some avg10=41.73 avg60=45.97 avg300=56.27 total=3385780085
    full avg10=21.78 avg60=18.15 avg300=25.35 total=1571263731
  ->
    some avg10=60.27 avg60=55.44 avg300=54.37 total=3599850643
    full avg10=19.52 avg60=20.91 avg300=23.58 total=1667430954
system/backup/memory.current  222130176       < 222543872
system/backup/memory.events.local
    low                       5446            = 5446
    high                      0               = 0
    max                       0               = 0
    oom                       0               = 0
    oom_kill                  0               = 0

system/shell/memory.min       0               = 0
system/shell/memory.low       0               = 0
system/shell/memory.high      max             = max
system/shell/memory.max       max             = max
system/shell/memory.pressure
    some avg10=0.00 avg60=0.12 avg300=0.25 total=1348427661
    full avg10=0.00 avg60=0.04 avg300=0.06 total=493582108
  ->
    some avg10=0.00 avg60=0.00 avg300=0.06 total=1348516773
    full avg10=0.00 avg60=0.00 avg300=0.00 total=493591500
system/shell/memory.current  8814592          < 8888320
system/shell/memory.events.local
    low                      0                = 0
    high                     0                = 0
    max                      0                = 0
    oom                      0                = 0
    oom_kill                 0                = 0

website/memory.min           0                = 0
website/memory.low           17179869184      = 17179869184
website/memory.high          45131717672960   = 45131717672960
website/memory.max           45131717672960   = 45131717672960
website/memory.pressure
    some avg10=0.00 avg60=0.00 avg300=0.00 total=415009408
    full avg10=0.00 avg60=0.00 avg300=0.00 total=201868483
  ->
    some avg10=0.00 avg60=0.00 avg300=0.00 total=415009408
    full avg10=0.00 avg60=0.00 avg300=0.00 total=201868483
website/memory.current       11811520512      > 11456942080
website/memory.events.local
    low                      11372142         < 11377350
    high                     0                = 0
    max                      0                = 0
    oom                      0                = 0
    oom_kill                 0                = 0

remote/memory.min            0
remote/memory.low            1073741824
remote/memory.high           15032385536
remote/memory.max            15032385536
remote/memory.pressure
    some avg10=0.00 avg60=0.25 avg300=0.50 total=2017364408
    full avg10=0.00 avg60=0.00 avg300=0.01 total=738071296
  ->
remote/memory.current        84439040         > 81797120
remote/memory.events.local
    low                      11372142         < 11377350
    high                     0                = 0
    max                      0                = 0
    oom                      0                = 0
    oom_kill                 0                = 0

websrv/memory.min            0                = 0
websrv/memory.low            4294967296       = 4294967296
websrv/memory.high           34359738368      = 34359738368
websrv/memory.max            34426847232      = 34426847232
websrv/memory.pressure
    some avg10=40.38 avg60=62.58 avg300=68.83 total=7760096704
    full avg10=7.80 avg60=10.78 avg300=12.64 total=2254679370
  ->
    some avg10=89.97 avg60=83.78 avg300=72.99 total=8040513640
    full avg10=11.46 avg60=11.49 avg300=11.47 total=2300116237
websrv/memory.current        18421673984      < 18421936128
websrv/memory.events.local
    low                      0                = 0
    high                     0                = 0
    max                      0                = 0
    oom                      0                = 0
    oom_kill                 0                = 0



Is there something important I'm missing in my setup that could prevent
things from starving?

Did memory.low meaning change between 5.7 and 5.9? From behavior it
feels as if inodes are not accounted to cgroup at all and kernel pushes
cgroups down to their memory.low by killing file cache if there is not
enough free memory to hold all promises (and not only when a cgroup
tries to use up to its promised amount of memory).
As system was trashing as much with 10G of file cache dropped
(completely unused memory) as with it in use.


I will try to create a test-case for it to reproduce it on a test
machine an be able to verify a fix or eventually bisect to triggering
patch though it this all rings a bell, please tell!

Note until I have a test-case I'm reluctant to just wait [on
production system] for next occurrence (usually at unpractical times) to
gather some more metrics.

Regards,
Bruno
