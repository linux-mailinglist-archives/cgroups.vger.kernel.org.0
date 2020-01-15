Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2E013B6BB
	for <lists+cgroups@lfdr.de>; Wed, 15 Jan 2020 02:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgAOBTX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Jan 2020 20:19:23 -0500
Received: from mga05.intel.com ([192.55.52.43]:6900 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgAOBTX (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 14 Jan 2020 20:19:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 17:19:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,320,1574150400"; 
   d="scan'208";a="225799881"
Received: from unknown (HELO localhost) ([10.239.159.54])
  by orsmga006.jf.intel.com with ESMTP; 14 Jan 2020 17:19:18 -0800
Date:   Wed, 15 Jan 2020 09:19:27 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, alexander.duyck@gmail.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200115011927.GB4916@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200114093122.GH19428@dhcp22.suse.cz>
 <20200114103112.o6ozdbkfnzdsc2ke@box>
 <20200114105921.eo2vdwikrvtt3gkb@box>
 <alpine.DEB.2.21.2001141254460.84781@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001141254460.84781@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 14, 2020 at 12:57:22PM -0800, David Rientjes wrote:
>On Tue, 14 Jan 2020, Kirill A. Shutemov wrote:
>
>> split_huge_page_to_list() has page lock taken.
>> 
>> free_transhuge_page() is in the free path and doesn't susceptible to the
>> race.
>> 
>> deferred_split_scan() is trickier. list_move() should be safe against
>> list_empty() as it will not produce false-positive list_empty().
>> list_del_init() *should* (correct me if I'm wrong) be safe because the page
>> is freeing and memcg will not touch the page anymore.
>> 
>> deferred_split_huge_page() is a problematic one. It called from
>> page_remove_rmap() path witch does require page lock. I don't see any
>> obvious way to exclude race with mem_cgroup_move_account() here.
>> Anybody else?
>> 
>> Wei, could you rewrite the commit message with deferred_split_huge_page()
>> as a race source instead of split_huge_page_to_list()?
>> 
>
>I think describing the race in terms of deferred_split_huge_page() makes 
>the most sense and I'd prefer a cc to stable for 5.4+.  Even getting the 
>split_queue_len, which is unsigned long, to underflow because of a 
>list_empty(page_deferred_list()) check that is no longer accurate after 
>the lock is taken would be a significant issue for shrinkers.

Oh, you are right. Even the list is not corrupted between
deferred_split_scan() and mem_cgroup_move_account(), split_queue_len would be
in a wrong state.

Hmm... to some extend, the page lock complicates the picture a little here,
even it helps in some cases.

-- 
Wei Yang
Help you, Help me
