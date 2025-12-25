Return-Path: <cgroups+bounces-12724-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11129CDDF07
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 17:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34637300EA36
	for <lists+cgroups@lfdr.de>; Thu, 25 Dec 2025 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977A26CE1A;
	Thu, 25 Dec 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="aDI56EEt"
X-Original-To: cgroups@vger.kernel.org
Received: from va-2-29.ptr.blmpb.com (va-2-29.ptr.blmpb.com [209.127.231.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F46726C38C
	for <cgroups@vger.kernel.org>; Thu, 25 Dec 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766681128; cv=none; b=YLaxZI6oJqKZpj/JI6oSwmt7I9GLNH88MEPyk73VKCIFuhHyzLnddsyb7HO89OAVoHPyihG7HXl2knf1Nx6lvcwnFPIIcdnRPZ4LNAk5o8NlqEMRqXLSscliwxfvOl65Ga0qhJ5kFu9/+RUDHtDtSx14pU73FUVwDxT2DrA5QkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766681128; c=relaxed/simple;
	bh=LZp7Rn7KVq7rL6RB3F9iQeNPCeJPLJqWhm4LFj+xDLc=;
	h=References:To:From:Date:Mime-Version:Content-Type:Cc:Subject:
	 Message-Id:In-Reply-To; b=KT6jJYteJfDcLEvonM/p5l/3kKTjy05QmlKqsGuXOBjpvbQMT2JISqWWzygbdOOzGc9GVbR7c/KMGDG7iaB8Bt+gYWBMeu1lAZrPwaPdX2UtHld0nWMTuN1QS5okRe5F6Itpow23lJnUcl91xZS0XdrOw/mBs8KI8IAzAZCVVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=none smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=aDI56EEt; arc=none smtp.client-ip=209.127.231.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1766681082;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=+ORxIbZHc36hCwJDvGUay9Dhj9NZj8XTOZ7wTnOOdzg=;
 b=aDI56EEtAvGpFlO5cNqCauzl5TsFiB+EI2BONjHIyO0sgqGkUncZ1Xs15ayPDepqrMnqwW
 YKWbZSejU9SDB/g8C/NO8TW3FnTd1S2S6mHkrtgiryGMLOYcZUtgu6WODm4qfeUkjH2W3+
 n3TnrtIbbWdcKQEbWyxAwkV2YlFdGXEsoak2Fny/hHY845g7hWoMnV6x9tZJiApBi+Y7ko
 1N0PKRS1hdvAdvLdHiGzo8V/GhdQkuxqmIYGmmhdjDJX1uSK7awsXp0jZ7HFnt00hZYxdH
 zqso6RYvvrSagAq7Bgv3BoOGL4IRshc8sMsNsGV/VpqCCugX4D/1kNZWg9BsMg==
References: <20251222021937.1280-1-shechenglong@xfusion.com>
Reply-To: yukuai@fnnas.com
To: "shechenglong" <shechenglong@xfusion.com>, <tj@kernel.org>, 
	<josef@toxicpanda.com>, <axboe@kernel.dk>
From: "Yu Kuai" <yukuai@fnnas.com>
Date: Fri, 26 Dec 2025 00:44:37 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Received: from [192.168.1.104] ([39.182.0.136]) by smtp.feishu.cn with ESMTPS; Fri, 26 Dec 2025 00:44:39 +0800
Content-Language: en-US
Cc: <cgroups@vger.kernel.org>, <linux-block@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stone.xulei@xfusion.com>, 
	<chenjialong@xfusion.com>, <yukuai@fnnas.com>
Subject: Re: [PATCH] block: fix aux stat accumulation destination
Message-Id: <71df89fb-1766-40d5-8dd5-5d0c6f49519e@fnnas.com>
X-Lms-Return-Path: <lba+2694d69f8+5a9340+vger.kernel.org+yukuai@fnnas.com>
In-Reply-To: <20251222021937.1280-1-shechenglong@xfusion.com>
User-Agent: Mozilla Thunderbird

Hi,

=E5=9C=A8 2025/12/22 10:19, shechenglong =E5=86=99=E9=81=93:
> Route bfqg_stats_add_aux() time accumulation into the destination
> stats object instead of the source, aligning with other stat fields.
>
> Signed-off-by: shechenglong <shechenglong@xfusion.com>
> ---
>   block/bfq-cgroup.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Please change the title and follow existing prefix:

block, bfq: fix aux stat accumulation destination

Otherwise, feel free to add:

Reviewed-by: Yu Kuai <yukuai@fnnas.com>

>
> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
> index 9fb9f3533150..6a75fe1c7a5c 100644
> --- a/block/bfq-cgroup.c
> +++ b/block/bfq-cgroup.c
> @@ -380,7 +380,7 @@ static void bfqg_stats_add_aux(struct bfqg_stats *to,=
 struct bfqg_stats *from)
>   	blkg_rwstat_add_aux(&to->merged, &from->merged);
>   	blkg_rwstat_add_aux(&to->service_time, &from->service_time);
>   	blkg_rwstat_add_aux(&to->wait_time, &from->wait_time);
> -	bfq_stat_add_aux(&from->time, &from->time);
> +	bfq_stat_add_aux(&to->time, &from->time);
>   	bfq_stat_add_aux(&to->avg_queue_size_sum, &from->avg_queue_size_sum);
>   	bfq_stat_add_aux(&to->avg_queue_size_samples,
>   			  &from->avg_queue_size_samples);

--=20
Thansk,
Kuai

