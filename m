Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2572131D1E
	for <lists+cgroups@lfdr.de>; Tue,  7 Jan 2020 02:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgAGBWj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 Jan 2020 20:22:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:6547 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727295AbgAGBWi (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 6 Jan 2020 20:22:38 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 17:22:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,404,1571727600"; 
   d="scan'208";a="420887474"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jan 2020 17:22:36 -0800
Date:   Tue, 7 Jan 2020 09:22:41 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yang.shi@linux.alibaba.com
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer list
Message-ID: <20200107012241.GA15341@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com>
 <20200106102345.GE12699@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106102345.GE12699@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jan 06, 2020 at 11:23:45AM +0100, Michal Hocko wrote:
>On Fri 03-01-20 22:34:07, Wei Yang wrote:
>> As all the other places, we grab the lock before manipulate the defer list.
>> Current implementation may face a race condition.
>
>Please always make sure to describe the effect of the change. Why a racy
>list_empty check matters?
>

Hmm... access the list without proper lock leads to many bad behaviors.

For example, if we grab the lock after checking list_empty, the page may
already be removed from list in split_huge_page_list. And then list_del_init
would trigger bug.

-- 
Wei Yang
Help you, Help me
