Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D236612FF32
	for <lists+cgroups@lfdr.de>; Sat,  4 Jan 2020 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgACXjZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jan 2020 18:39:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:46435 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgACXjZ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 3 Jan 2020 18:39:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2020 15:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,392,1571727600"; 
   d="scan'208";a="252740373"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 03 Jan 2020 15:39:23 -0800
Date:   Sat, 4 Jan 2020 07:39:25 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200103233925.GA3678@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.2001031128200.160920@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001031128200.160920@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 03, 2020 at 11:29:06AM -0800, David Rientjes wrote:
>On Fri, 3 Jan 2020, Wei Yang wrote:
>
>> As all the other places, we grab the lock before manipulate the defer list.
>> Current implementation may face a race condition.
>> 
>> Fixes: 87eaceb3faa5 ("mm: thp: make deferred split shrinker memcg aware")
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> 
>> ---
>> I notice the difference during code reading and just confused about the
>> difference. No specific test is done since limited knowledge about cgroup.
>> 
>> Maybe I miss something important?
>
>The check for !list_empty(page_deferred_list(page)) must certainly be 
>serialized with doing list_del_init(page_deferred_list(page)).
>

Hi David

Would you mind giving more information? You mean list_empty and list_del_init
is atomic?

-- 
Wei Yang
Help you, Help me
