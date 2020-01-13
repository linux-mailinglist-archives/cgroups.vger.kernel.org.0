Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684BD13891B
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 01:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgAMApG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sun, 12 Jan 2020 19:45:06 -0500
Received: from mga03.intel.com ([134.134.136.65]:32857 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387539AbgAMApG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Sun, 12 Jan 2020 19:45:06 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jan 2020 16:45:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,427,1571727600"; 
   d="scan'208";a="247559206"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga004.fm.intel.com with ESMTP; 12 Jan 2020 16:45:03 -0800
Date:   Mon, 13 Jan 2020 08:44:57 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200113004457.GA27762@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200112022858.GA17733@richard>
 <20200112225718.5vqzezfclacujyx3@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200112225718.5vqzezfclacujyx3@box>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 13, 2020 at 01:57:18AM +0300, Kirill A. Shutemov wrote:
>On Sun, Jan 12, 2020 at 10:28:58AM +0800, Wei Yang wrote:
>> On Sat, Jan 11, 2020 at 03:03:52AM +0300, Kirill A. Shutemov wrote:
>> >On Thu, Jan 09, 2020 at 10:30:54PM +0800, Wei Yang wrote:
>> >> As all the other places, we grab the lock before manipulate the defer list.
>> >> Current implementation may face a race condition.
>> >> 
>> >> For example, the potential race would be:
>> >> 
>> >>     CPU1                      CPU2
>> >>     mem_cgroup_move_account   split_huge_page_to_list
>> >>       !list_empty
>> >>                                 lock
>> >>                                 !list_empty
>> >>                                 list_del
>> >>                                 unlock
>> >>       lock
>> >>       # !list_empty might not hold anymore
>> >>       list_del_init
>> >>       unlock
>> >
>> >I don't think this particular race is possible. Both parties take page
>> >lock before messing with deferred queue, but anytway:
>> 
>> I am afraid not. Page lock is per page, while defer queue is per pgdate or
>> memcg.
>> 
>> It is possible two page in the same pgdate or memcg grab page lock
>> respectively and then access the same defer queue concurrently.
>
>Look closer on the list_empty() argument. It's list_head local to the
>page. Too different pages can be handled in parallel without any problem
>in this particular scenario. As long as we as we modify it under the lock.
>
>Said that, page lock here was somewhat accidential and I still belive we
>need to move the check under the lock anyway.
>

If my understanding is correct, you agree with my statement?

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
