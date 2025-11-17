Return-Path: <cgroups+bounces-12048-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C542C66252
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 21:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0AC394E3328
	for <lists+cgroups@lfdr.de>; Mon, 17 Nov 2025 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C6D319875;
	Mon, 17 Nov 2025 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cD4dC/M9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CTP67pCH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECF3093AE
	for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763412631; cv=none; b=fe6uK/XEP/woCxN55Fx6yirlIzpz2ZWog5jMTwMlVzy8u+o8xZTuiWKA0zs6HBO8ZzmpsT50qrBDhDRh54SjEbEb86RNyYZ87SyYJljIVe0sjGiLQwkGMrtNlHNadu0JvvfHAt2bMlHWahkWspSWv9Nj7j+hEHOeX6BfBp7Lwqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763412631; c=relaxed/simple;
	bh=iTDw2sXymZVOxmraPAFZ4IFal7IrCX/rogWy3d5ivc8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=F8xU/k05D2Z7ka9b9+at1FEKF7wk900/Kb84R2deDe2JifQ2/ygw4s8oEk1XN8nDahI3BLxYH+Y3L/+xAP2Z8pGoPW/8og6j7ZHu2tgmtruOEUC2RJJhGoEkB8GXrPEtzKpzi4stXEWnCHVdeMFXUQ/Qv6zCz2/ITCfiGNONR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cD4dC/M9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CTP67pCH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763412628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=49uZWUi3tUOvugaZjqm25X08vrc3EIGz57ACFwR7xhs=;
	b=cD4dC/M9McT2ikqfoxoreZTMKlZEBmkRfpf50TbUZ9yTn5cEaNLhBJHoRIB8KNoFrOvFm8
	YWz0RU3xGoMWZ8I8UgSF/RP4XlIqsvS7PtDXaw1tVIpgT1rWmoKCiYF6F279V3EbEJ7u2r
	nO2UE6CdkjJ9yfgKpADXUALhWE1EdNM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-U-yLpUVrP16BkfN-0WdE3Q-1; Mon, 17 Nov 2025 15:50:27 -0500
X-MC-Unique: U-yLpUVrP16BkfN-0WdE3Q-1
X-Mimecast-MFC-AGG-ID: U-yLpUVrP16BkfN-0WdE3Q_1763412627
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8804b9afe30so204502996d6.0
        for <cgroups@vger.kernel.org>; Mon, 17 Nov 2025 12:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763412627; x=1764017427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=49uZWUi3tUOvugaZjqm25X08vrc3EIGz57ACFwR7xhs=;
        b=CTP67pCH2810nKUckaKalKtn5gBtN2K/4EglEUyCrX5qF7eylO6soK9FP/8s2H/lZL
         0yl196rRoY+m9dAMb7SkLHIqKpYLHR1kPqQXHNaBd+sPeEbZDSzYZ76st2dO4C831VOD
         H1nVsrE/2BGIjL5zvHS179In6zksMJe0+482wWR0jmpmtAWOG505jFlWMb/J/VtveZdq
         2NLTtC/v96gmgUSNNTMOV3ROS/UsKozFCZFFTw9PnRFHegiW0p7MNlbE1GYKkvi6MQg0
         4tbTdJmTIO3cj/9K3VIsUtLKfvk38IAfhHXNKbv5leDbjSYTgY1EY+dZHegORFxLDya9
         gyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763412627; x=1764017427;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=49uZWUi3tUOvugaZjqm25X08vrc3EIGz57ACFwR7xhs=;
        b=bR2dcGBYAGf3g9hJ6mw/UE5OlPN26A6YwClxmag/juBAn/K7hGSrHPMMfsr/KfDkMC
         R1OIxGaAeq2pHInbMknIjUMtHrwZ7IWNzBtQtGR7RaZhMWQEs3TqqFiNfBoeGEaYPLiA
         sLZgiLqFmyLensSWDvPc05qHr/5pNc4YYtI9j1PiDv78TcoqFYnvMSsudHp6ttDdelDa
         ayGTA+VpbrAdCk9a52AqKvyeLklho7gpzhDv5E0QCURTJwc2aGTsUlfmRDmcOt1q+TKd
         pZ0lC2YAFkUl5x6mUViRATZsRoLmfaE+PrQ7h68Cn/16lY6MQoTbn/i2uYNEs/geHOrY
         iVeg==
X-Gm-Message-State: AOJu0Yy8X7Yl8j+dA4iIcj4JZH8D8DSs5KmTvklmK5ZHpsZvYMVrt6hn
	DHnwwwSytac8NeeON47ef3to388hv8Ub3PdSzqjzchF6JhD+h4UR1HnYu7WEpJieikUafEEKF40
	P5eoUN4nB6iLzXJp7l5jAytTaL858UlqdNkDbJOja0MrcYNfpt6ok7K025Sg=
X-Gm-Gg: ASbGncs631JrnTpZHICjmDnBcmnw2L094FBI2eT6Sr+taLcpTR4p/nBzfiLsQB7Dk9E
	rropABSs2vmivW8GpLTAcAleNJJGU/eA4uRwnIl7n12Y9hKTk/zI+ohLOglRTzpGvWvIvSiieLj
	hNYXNKI5AlSiOghXj+tkjQFcy2ym688gTxRrGHvgCQJhwbmHnb6mByCHpgKP+HFgtycZ4SAYHqy
	4H6e7qC41cEQyKH5C6ZPuDImVOOq3tAyHxTooT1LBgzhCryO1I7BTmKBcBjgTv6/3252y3VK6Ka
	KtrHol7qfE0vUqK1aPOSsB0JuSYAWh0l8CWQCrrK2wb7fIfmiN7opE/9MuruXBzxomeqsmTs/lf
	laNPQStLqfUOWxMj7/LBhU6tcRDpcu3ANjo2Qy651j1l/1Q==
X-Received: by 2002:ad4:4ea5:0:b0:882:4632:cf7e with SMTP id 6a1803df08f44-882925bdb7amr193219486d6.12.1763412626854;
        Mon, 17 Nov 2025 12:50:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvtmUHJOgdOp9Ll8LYfjQHw13mjo1gfl8WaqWutebE1EEcEghA6cIfuHVo8ijvaG0eeD5fpQ==
X-Received: by 2002:ad4:4ea5:0:b0:882:4632:cf7e with SMTP id 6a1803df08f44-882925bdb7amr193219186d6.12.1763412626436;
        Mon, 17 Nov 2025 12:50:26 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286577cbesm100345946d6.46.2025.11.17.12.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Nov 2025 12:50:25 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <145d57ba-ed38-40b6-a495-57691cb41b63@redhat.com>
Date: Mon, 17 Nov 2025 15:50:24 -0500
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3] cpuset: Treat cpusets in attaching as populated
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20251114020847.1040546-1-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20251114020847.1040546-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/25 9:08 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Currently, the check for whether a partition is populated does not
> account for tasks in the cpuset of attaching. This is a corner case
> that can leave a task stuck in a partition with no effective CPUs.
>
> The race condition occurs as follows:
>
> cpu0				cpu1
> 				//cpuset A  with cpu N
> migrate task p to A
> cpuset_can_attach
> // with effective cpus
> // check ok
>
> // cpuset_mutex is not held	// clear cpuset.cpus.exclusive
> 				// making effective cpus empty
> 				update_exclusive_cpumask
> 				// tasks_nocpu_error check ok
> 				// empty effective cpus, partition valid
> cpuset_attach
> ...
> // task p stays in A, with non-effective cpus.
>
> To fix this issue, this patch introduces cs_is_populated, which considers
> tasks in the attaching cpuset. This new helper is used in validate_change
> and partition_is_populated.
>
> Fixes: e2d59900d936 ("cgroup/cpuset: Allow no-task partition to have empty cpuset.cpus.effective")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 35 +++++++++++++++++++++++++++--------
>   1 file changed, 27 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index daf813386260..8bf7c38ba320 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -356,6 +356,15 @@ static inline bool is_in_v2_mode(void)
>   	      (cpuset_cgrp_subsys.root->flags & CGRP_ROOT_CPUSET_V2_MODE);
>   }
>   
> +static inline bool cpuset_is_populated(struct cpuset *cs)
> +{
> +	lockdep_assert_held(&cpuset_mutex);
> +
> +	/* Cpusets in the process of attaching should be considered as populated */
> +	return cgroup_is_populated(cs->css.cgroup) ||
> +		cs->attach_in_progress;
> +}
> +
>   /**
>    * partition_is_populated - check if partition has tasks
>    * @cs: partition root to be checked
> @@ -373,19 +382,29 @@ static inline bool is_in_v2_mode(void)
>   static inline bool partition_is_populated(struct cpuset *cs,
>   					  struct cpuset *excluded_child)
>   {
> -	struct cgroup_subsys_state *css;
> -	struct cpuset *child;
> +	struct cpuset *cp;
> +	struct cgroup_subsys_state *pos_css;
>   
> -	if (cs->css.cgroup->nr_populated_csets)
> +	/*
> +	 * We cannot call cs_is_populated(cs) directly, as
> +	 * nr_populated_domain_children may include populated
> +	 * csets from descendants that are partitions.
> +	 */
> +	if (cs->css.cgroup->nr_populated_csets ||
> +	    cs->attach_in_progress)
>   		return true;
>   
>   	rcu_read_lock();
> -	cpuset_for_each_child(child, css, cs) {
> -		if (child == excluded_child)
> +	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> +		if (cp == cs || cp == excluded_child)
>   			continue;
> -		if (is_partition_valid(child))
> +
> +		if (is_partition_valid(cp)) {
> +			pos_css = css_rightmost_descendant(pos_css);
>   			continue;
> -		if (cgroup_is_populated(child->css.cgroup)) {
> +		}
> +
> +		if (cpuset_is_populated(cp)) {
>   			rcu_read_unlock();
>   			return true;
>   		}
> @@ -670,7 +689,7 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
>   	 * be changed to have empty cpus_allowed or mems_allowed.
>   	 */
>   	ret = -ENOSPC;
> -	if ((cgroup_is_populated(cur->css.cgroup) || cur->attach_in_progress)) {
> +	if (cpuset_is_populated(cur)) {
>   		if (!cpumask_empty(cur->cpus_allowed) &&
>   		    cpumask_empty(trial->cpus_allowed))
>   			goto out;
Reviewed-by: Waiman Long <longman@redhat.com>


