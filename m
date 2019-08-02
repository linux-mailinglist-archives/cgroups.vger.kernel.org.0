Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2112D800B6
	for <lists+cgroups@lfdr.de>; Fri,  2 Aug 2019 21:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391895AbfHBTOe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 2 Aug 2019 15:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36546 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbfHBTOe (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 2 Aug 2019 15:14:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAA03AD43;
        Fri,  2 Aug 2019 19:14:32 +0000 (UTC)
Date:   Fri, 2 Aug 2019 21:14:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Masoud Sharbiani <msharbiani@apple.com>
Cc:     gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Possible mem cgroup bug in kernels between 4.18.0 and 5.3-rc1.
Message-ID: <20190802191430.GO6461@dhcp22.suse.cz>
References: <5659221C-3E9B-44AD-9BBF-F74DE09535CD@apple.com>
 <20190802074047.GQ11627@dhcp22.suse.cz>
 <7E44073F-9390-414A-B636-B1AE916CC21E@apple.com>
 <20190802144110.GL6461@dhcp22.suse.cz>
 <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5DE6F4AE-F3F9-4C52-9DFC-E066D9DD5EDC@apple.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri 02-08-19 11:00:55, Masoud Sharbiani wrote:
> 
> 
> > On Aug 2, 2019, at 7:41 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Fri 02-08-19 07:18:17, Masoud Sharbiani wrote:
> >> 
> >> 
> >>> On Aug 2, 2019, at 12:40 AM, Michal Hocko <mhocko@kernel.org> wrote:
> >>> 
> >>> On Thu 01-08-19 11:04:14, Masoud Sharbiani wrote:
> >>>> Hey folks,
> >>>> I’ve come across an issue that affects most of 4.19, 4.20 and 5.2 linux-stable kernels that has only been fixed in 5.3-rc1.
> >>>> It was introduced by
> >>>> 
> >>>> 29ef680 memcg, oom: move out_of_memory back to the charge path 
> >>> 
> >>> This commit shouldn't really change the OOM behavior for your particular
> >>> test case. It would have changed MAP_POPULATE behavior but your usage is
> >>> triggering the standard page fault path. The only difference with
> >>> 29ef680 is that the OOM killer is invoked during the charge path rather
> >>> than on the way out of the page fault.
> >>> 
> >>> Anyway, I tried to run your test case in a loop and leaker always ends
> >>> up being killed as expected with 5.2. See the below oom report. There
> >>> must be something else going on. How much swap do you have on your
> >>> system?
> >> 
> >> I do not have swap defined. 
> > 
> > OK, I have retested with swap disabled and again everything seems to be
> > working as expected. The oom happens earlier because I do not have to
> > wait for the swap to get full.
> > 
> 
> In my tests (with the script provided), it only loops 11 iterations before hanging, and uttering the soft lockup message.
> 
> 
> > Which fs do you use to write the file that you mmap?
> 
> /dev/sda3 on / type xfs (rw,relatime,seclabel,attr2,inode64,logbufs=8,logbsize=32k,noquota)
> 
> Part of the soft lockup path actually specifies that it is going through __xfs_filemap_fault():

Right, I have just missed that.

[...]

> If I switch the backing file to a ext4 filesystem (separate hard drive), it OOMs.
> 
> 
> If I switch the file used to /dev/zero, it OOMs: 
> …
> Todal sum was 0. Loop count is 11
> Buffer is @ 0x7f2b66c00000
> ./test-script-devzero.sh: line 16:  3561 Killed                  ./leaker -p 10240 -c 100000
> 
> 
> > Or could you try to
> > simplify your test even further? E.g. does everything work as expected
> > when doing anonymous mmap rather than file backed one?
> 
> It also OOMs with MAP_ANON. 
> 
> Hope that helps.

It helps to focus more on the xfs reclaim path. Just to be sure, is
there any difference if you use cgroup v2? I do not expect to be but
just to be sure there are no v1 artifacts.
-- 
Michal Hocko
SUSE Labs
