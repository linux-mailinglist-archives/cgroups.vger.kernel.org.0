Return-Path: <cgroups+bounces-6153-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24124A1106C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 19:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C7E16719C
	for <lists+cgroups@lfdr.de>; Tue, 14 Jan 2025 18:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D181FA8CF;
	Tue, 14 Jan 2025 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MfPKZ9VU"
X-Original-To: cgroups@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA061FCFF8
	for <cgroups@vger.kernel.org>; Tue, 14 Jan 2025 18:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736880330; cv=none; b=g7K8d5mfkiINF54hjVnu9YICbNuOSWFO3DdwUSfkSZ7388kdLHCzrLeYB2WiGOMwycjIzKdve9su//vSaraWppyCgHpPArjgi9lUGobH61XEOh2rPGMEmIuXZQtIBNHpgQqKzqN8fup5afwdAjfXlCLmo5uNeJKRwaMU9ecOCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736880330; c=relaxed/simple;
	bh=m7K73y9TdCEg/XYZTLhrzPjsAnR9a8CBbYsuSHxh+ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g82SRXWoutjcWCcofARW1I2TdTocqOgEDcp2BTOSoddsxm9+VkMlHtURd7CQjG2kdr/4vHYPOtslGo4PmWE10H3IC5jihLmc9+gDlEXSDiR93MlrqS6iPJHwv4QGlP9i7amg4k0NwglrD6K/8J+CoMRnPmoJORxhJYlTU2sQ9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MfPKZ9VU; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 14 Jan 2025 18:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736880325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FNSFiyYPAa6A/FMcmK9OpHCn7WP9eS7Gp3baqfoLLKE=;
	b=MfPKZ9VUnFamTOvff07luOem2NlkuLolL+dAWjPzQXqeNWp6gfTnIDn2lGaQ24vcbRPjAw
	vYPVMfiuM2GkYxLd4JCF+sRMgazylbKGNC3+svPb7n3EgMaI0EYZRUNVmcGdV8pGNrl9Kc
	Csjz6IxCTe/UpUsicdoD9r2XtJy34DM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org,
	yosryahmed@google.com, shakeel.butt@linux.dev,
	muchun.song@linux.dev, davidf@vimeo.com, vbabka@suse.cz,
	mkoutny@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, chenridong@huawei.com,
	wangweiyang2@huawei.com
Subject: Re: [PATCH -v2 next 4/4] memcg: factor out
 stat(event)/stat_local(event_local) reading functions
Message-ID: <Z4awwH3cbhjl0H4W@google.com>
References: <20250114122519.1404275-1-chenridong@huaweicloud.com>
 <20250114122519.1404275-5-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114122519.1404275-5-chenridong@huaweicloud.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jan 14, 2025 at 12:25:19PM +0000, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> The only difference between 'lruvec_page_state' and
> 'lruvec_page_state_local' is that they read 'state' and 'state_local',
> respectively. Factor out an inner functions to make the code more concise.
> Do the same for reading 'memcg_page_stat' and 'memcg_events'.
> 
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/memcontrol.c | 72 +++++++++++++++++++++----------------------------
>  1 file changed, 30 insertions(+), 42 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b10e0a8f3375..14541610cad0 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -375,7 +375,8 @@ struct lruvec_stats {
>  	long state_pending[NR_MEMCG_NODE_STAT_ITEMS];
>  };
>  
> -unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> +static unsigned long __lruvec_page_state(struct lruvec *lruvec,
> +		enum node_stat_item idx, bool local)
>  {
>  	struct mem_cgroup_per_node *pn;
>  	long x;
> @@ -389,7 +390,8 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>  		return 0;
>  
>  	pn = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	x = READ_ONCE(pn->lruvec_stats->state[i]);
> +	x = local ? READ_ONCE(pn->lruvec_stats->state_local[i]) :
> +		    READ_ONCE(pn->lruvec_stats->state[i]);
>  #ifdef CONFIG_SMP
>  	if (x < 0)
>  		x = 0;
> @@ -397,27 +399,16 @@ unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
>  	return x;
>  }
>  
> +
> +unsigned long lruvec_page_state(struct lruvec *lruvec, enum node_stat_item idx)
> +{
> +	return __lruvec_page_state(lruvec, idx, false);
> +}

I'd move these wrapper function definitions to memcontrol.h and make them
static inline.

Other than that, lgtm.

Thank you!

