Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94766371C3
	for <lists+cgroups@lfdr.de>; Thu, 24 Nov 2022 06:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKXF26 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 24 Nov 2022 00:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKXF25 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 24 Nov 2022 00:28:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF39C052C;
        Wed, 23 Nov 2022 21:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669267736; x=1700803736;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=yzllx2aXHanc4RlM697MHQ9doyide2+HpLsBlPh6fPY=;
  b=a7dd0UFqA3/b8+LxYo0ChDAgo7WfRQGqC1iCpvwDfDhxowOyxepWaw59
   apO8di9w/hQ9DO5tyKbiukx/RD58d+9ULQ2jxwo8wCBoeL/o76M4lqglR
   kBjEX7DKXNZdWdOiB5k07/fu6jm6VMbne4/S5R6Hf9voHISOupa1ZgfDR
   M2IInhX9pJAR2UDZ+HL/29V9P4HE8VjSq3PtrnHKoTW7BZEsRtq1hes5l
   u8QABUokbJdktH0woThF8vlEusrI1zMxyCJxP1gplu4bJIL7Z63Yf/BFe
   vsKz75MvKFdxLlqkiIX3FVlZRGQg0cPTptorCBnyo18l/j8+YbRVbTvxS
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="316039962"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="316039962"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:28:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10540"; a="887219634"
X-IronPort-AV: E=Sophos;i="5.96,189,1665471600"; 
   d="scan'208";a="887219634"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2022 21:28:52 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, weixugc@google.com,
        shakeelb@google.com, gthelen@google.com, fvdl@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 3/4] mm: Fix demotion-only scanning anon pages
References: <20221122203850.2765015-1-almasrymina@google.com>
        <20221122203850.2765015-3-almasrymina@google.com>
Date:   Thu, 24 Nov 2022 13:27:51 +0800
In-Reply-To: <20221122203850.2765015-3-almasrymina@google.com> (Mina Almasry's
        message of "Tue, 22 Nov 2022 12:38:47 -0800")
Message-ID: <87wn7korag.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> This is likely a missed change from commit a2a36488a61c ("mm/vmscan: Consider
> anonymous pages without swap"). Current logic is if !may_swap _or_
> !can_reclaim_anon_pages() then we don't scan anon memory.
>
> This should be an 'and'. We would like to scan anon memory if we may swap
> or if we can_reclaim_anon_pages().
>
> Fixes: commit a2a36488a61c ("mm/vmscan: Consider anonymous pages without swap")
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  mm/vmscan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 8c1f5416d789..d7e509b3f07f 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2931,7 +2931,7 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
>  	enum lru_list lru;
>
>  	/* If we have no swap space, do not bother scanning anon folios. */
> -	if (!sc->may_swap || !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {
> +	if (!sc->may_swap && !can_reclaim_anon_pages(memcg, pgdat->node_id, sc)) {

If there is only DRAM but swap device is enabled, sc->may_swap will not
work as expected.  So we should check can_demote() instead if
sc->may_swap.

Best Regards,
Huang, Ying

>  		scan_balance = SCAN_FILE;
>  		goto out;
>  	}
> --
> 2.38.1.584.g0f3c55d4c2-goog
