Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BA7138CC2
	for <lists+cgroups@lfdr.de>; Mon, 13 Jan 2020 09:23:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgAMIXS (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 13 Jan 2020 03:23:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:18442 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728738AbgAMIXS (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 13 Jan 2020 03:23:18 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 00:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,428,1571727600"; 
   d="scan'208";a="422737910"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 13 Jan 2020 00:23:15 -0800
Date:   Mon, 13 Jan 2020 16:23:08 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, yang.shi@linux.alibaba.com,
        alexander.duyck@gmail.com, rientjes@google.com
Subject: Re: [Patch v2] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200113082308.GB27972@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200109143054.13203-1-richardw.yang@linux.intel.com>
 <20200111000352.efy6krudecpshezh@box>
 <20200112022858.GA17733@richard>
 <20200112225718.5vqzezfclacujyx3@box>
 <20200113004457.GA27762@richard>
 <20200113073614.jo2txcmazwlesl7b@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113073614.jo2txcmazwlesl7b@box.shutemov.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 13, 2020 at 10:36:14AM +0300, Kirill A. Shutemov wrote:
>On Mon, Jan 13, 2020 at 08:44:57AM +0800, Wei Yang wrote:
>> >> It is possible two page in the same pgdate or memcg grab page lock
>> >> respectively and then access the same defer queue concurrently.
>> 
>> If my understanding is correct, you agree with my statement?
>
>Which one? If the one above then no. list_empty only accesses list_head
>for the struct page, not the queue.
>

Ah, I get your point.

>-- 
> Kirill A. Shutemov

-- 
Wei Yang
Help you, Help me
