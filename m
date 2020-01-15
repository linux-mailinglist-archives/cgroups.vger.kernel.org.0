Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCAE13B6AE
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2020 02:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgAOBHQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 20:07:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:5585 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgAOBHP (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 Jan 2020 20:07:15 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 17:07:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="256548046"
Received: from unknown (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2020 17:07:12 -0800
Date:   Wed, 15 Jan 2020 09:07:22 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com,
        rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200115010722.GA4916@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200114093122.GH19428@dhcp22.suse.cz>
 <20200114103112.o6ozdbkfnzdsc2ke@box>
 <20200114105921.eo2vdwikrvtt3gkb@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114105921.eo2vdwikrvtt3gkb@box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 14, 2020 at 01:59:21PM +0300, Kirill A. Shutemov wrote:
>On Tue, Jan 14, 2020 at 01:31:12PM +0300, Kirill A. Shutemov wrote:
>> On Tue, Jan 14, 2020 at 10:31:22AM +0100, Michal Hocko wrote:
>> > On Sat 11-01-20 03:03:52, Kirill A. Shutemov wrote:
>> > > On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
>> > > > As all the other places, we grab the lock before manipulate the defer list.
>> > > > Current implementation may face a race condition.
>> > > > 
>> > > > For example, the potential race would be:
>> > > > 
>> > > >     CPU1                      CPU2
>> > > >     mem_cgroup_move_account   split_huge_page_to_list
>> > > >       !list_empty
>> > > >                                 lock
>> > > >                                 !list_empty
>> > > >                                 list_del
>> > > >                                 unlock
>> > > >       lock
>> > > >       # !list_empty might not hold anymore
>> > > >       list_del_init
>> > > >       unlock
>> > > 
>> > > I don't think this particular race is possible. Both parties take page
>> > > lock before messing with deferred queue, but anytway:
>> > > 
>> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> > 
>> > I am confused, if the above race is not possible then what would be a
>> > real race? We really do not want to have a patch with a misleading
>> > changelog, do we?
>> 
>> The alternative is to make sure that all page_deferred_list() called with
>> page lock taken.
>> 
>> I'll look into it.
>
>split_huge_page_to_list() has page lock taken.
>
>free_transhuge_page() is in the free path and doesn't susceptible to the
>race.
>
>deferred_split_scan() is trickier. list_move() should be safe against
>list_empty() as it will not produce false-positive list_empty().
>list_del_init() *should* (correct me if I'm wrong) be safe because the page
>is freeing and memcg will not touch the page anymore.
>
>deferred_split_huge_page() is a problematic one. It called from
>page_remove_rmap() path witch does require page lock. I don't see any
>obvious way to exclude race with mem_cgroup_move_account() here.
>Anybody else?

If my understanding is correct, the reason is deferred_split_huge_page()
doesn't has page lock taken, right?

>
>Wei, could you rewrite the commit message with deferred_split_huge_page()
>as a race source instead of split_huge_page_to_list()?
>
>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
