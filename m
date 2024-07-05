Return-Path: <cgroups+bounces-3550-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59000928CE6
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 19:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1000528BD7F
	for <lists+cgroups@lfdr.de>; Fri,  5 Jul 2024 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7E6416F85D;
	Fri,  5 Jul 2024 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="YoHVPQso"
X-Original-To: cgroups@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB7816D4FB;
	Fri,  5 Jul 2024 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720199174; cv=none; b=lyJNKSmwoU6rRU6f3UvnqWmDHsOHXPda4xy+gnqHvCzXAOtO2NjxlthMJBNBTTDK1DBIuMDlpmgLYMkbl2WInacc9dCYWNtt7hl5+Ftl7vh/2R6n1DryoDzBf69OqhJDPo24SoIH+ROKBVfBffFoMOV0D+SXF1wRq5KNCXM1tz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720199174; c=relaxed/simple;
	bh=J/bxdK0kFjcJ1AbwT2VZgzLZ+UKkfCQOvnVkZF/t3K4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=gw5b7gTXE0YxJ+sS7GgqKXwaOwyBf/ujfM+eKwc9+6S2stRFuxxojazso5wKrTURDngqYACq/3+NTqsvmk/yXktp8LH4aszMXaEaQuO5OUU0EazBtqLKEnjTJlLuTiNLBvp6Nvf0vEjmWAgkN3u3XX+3XTrAZZaXeAu8QeQDZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=YoHVPQso; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1720199145; x=1720803945; i=markus.elfring@web.de;
	bh=u2RooQsdyisGBlzqbeOLqTi+HuxdjKBsH+GNi9Ka0GU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YoHVPQsoBN3B/qcTdZFHrZgvbtHbAGusVseeGnXZtkTw8KYzrLYEVIdzI7ZXUaxp
	 FiAPrRuV6K0p9VD7re9PAW7fdSdSpSgjQTMvtsGqMIhb6Ng3dyj8iTTatJ3PCOywI
	 XYpRyhfL1QndX8DQ6c5kRTEFrW/Gh9cPsiB/hE7C2vob2soo9eaq5oDVrH1/9Qnrl
	 2jS4YFSJkwh0TLx6Sd18RMC7v8N/942AtfkzC3tDICS2GOMy5rPiEO0gKrOc6oSa7
	 0RhMP4eVBPV2v2ZXQK+DW0n8DOVWTehAiTRXASgaH3vxDfNpLlcFEehm7Q1xE9/Qr
	 hwe9MPiGycmrqtrmig==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M7elj-1sTNHY1lML-00EUla; Fri, 05
 Jul 2024 19:05:45 +0200
Message-ID: <8f3765db-842d-4568-9ac5-1bd9cab9e952@web.de>
Date: Fri, 5 Jul 2024 19:05:39 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Boy Wu <boy.wu@mediatek.com>, cgroups@vger.kernel.org,
 linux-block@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Boris Burkov <boris@bur.io>, =?UTF-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?=
 <Iverlin.Wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20240705075544.11315-1-boy.wu@mediatek.com>
Subject: Re: [PATCH] blk-cgroup: add spin_lock for u64_stats_update
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240705075544.11315-1-boy.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ayo5EbRwEqmDRRhHjbrfG+GdJmG5xslZvjTVpGIYlCSYDs2UzI0
 7tLAgu/BT63IofbURgzLmEiBsCmRrwDzc7tjNThfuJ4yKgonQDUpXhAZyX75iNzoeBqB18r
 z24cVHK/zq5pC7HvnePynvxIwShUhjh7nulYiHE40cvYMBBLJd4TBgYfO4OjLpXojO7db0L
 JAK+TppIqxNJ5E2OqwiLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q8o9wnhjwg8=;fuUncGxrazjlzlVcIbRUWBGnGZV
 RroQTojOMj6YFd+0bsebNN68Dt2bjb7X/lNW1QETrdDyJlYI3jibXd+EvwRhxvI3hX4kSppgI
 URytC5GEnf5cPQKEtT5cxJ+Z9Zalz7eqwIJ5YM8g7NIbSm54VFpT9h1T+r0N70cQu07yzfOC/
 +jzL/dmlOFVXKB5yjJfhJVcwNSsRbRhJF2qdP3qVK703xlLBsLZL+NKgYrsom6fpaeW3Z8Otm
 ysJ/n0jsF1savRAnCYYmrasdeOLBty8ZjP0rXoVU7H7nBBGX8mkw5qlwgFEd+cINjgeyF90Mi
 dWak2869vcFk8CTs9eKcmci9tr4OindQoL9wQMnL7ZJARO7ES8gJEApVypfJqeCD61QQD1nbz
 P8IKTYwRjYTa8kuK+bjEDjal9pp0OAtU8PC5O0+294PHON+Z9N8/yCaE2wWi2xOs/InE8Eclf
 SUDqby7e11ILnu7rrbmWKZc2FMSAcdO+zW5vS28X6eAgqoAJBtdKvDGRuBaqqV0PMGsCTPvb6
 l/tAuFVWWUhxpwBwQJ1kXVNNsju+exec+oYkmO8SKzzVfhNdYZQxCbpwaGRTPmSDiETeZ/X5Q
 fb+M8KiBzpUFSwElStP0ca9CU0lRYZVx2chkSWxE5SdA0LK2y6vJIfqeC4TO510AvlE26gRxG
 SEO4HKWrt602m/16cjY7HuQHacolS9uMikW4lQSNZP/CjV9OIx03NrkDwErc956jxMMGPnkyz
 PIdLoScwDf/KFhFXJfCZS+NjdPgXNACWkNS256Izw7ojF42fN53wq3phhjjY2GjVG36y+uvNt
 69FIquVHwEABPeex/qoHnhsSpwNZ6yL1FaWF1JqM7mL/I=

> In 32bit SMP systems, if the system is stressed on the sys node
> by processes, it may cause blkcg_fill_root_iostats to have a concurrent
> problem on the seqlock in u64_stats_update, which will cause a deadlock
> on u64_stats_fetch_begin in blkcg_print_one_stat.

Would you like to mark any references to functions with parentheses?


> To prevent this problem, add spin_locks.

Another wording suggestion:
  Thus use an additional spin lock.


How do you think about to use a summary phrase like =E2=80=9CAdd a spin lo=
ck for stats update
in blkcg_fill_root_iostats()=E2=80=9D?


=E2=80=A6
> +++ b/block/blk-cgroup.c
> @@ -1134,9 +1134,15 @@ static void blkcg_fill_root_iostats(void)
>  				cpu_dkstats->sectors[STAT_DISCARD] << 9;
>  		}
>
> +#if BITS_PER_LONG =3D=3D 32
> +		spin_lock_irq(&blkg->q->queue_lock);
> +#endif
>  		flags =3D u64_stats_update_begin_irqsave(&blkg->iostat.sync);
>  		blkg_iostat_set(&blkg->iostat.cur, &tmp);
>  		u64_stats_update_end_irqrestore(&blkg->iostat.sync, flags);
> +#if BITS_PER_LONG =3D=3D 32
> +		spin_unlock_irq(&blkg->q->queue_lock);
> +#endif
=E2=80=A6

Under which circumstances would you become interested to apply a statement
like =E2=80=9Cguard(spinlock_irq)(&blkg->q->queue_lock);=E2=80=9D?
https://elixir.bootlin.com/linux/v6.10-rc6/source/include/linux/spinlock.h=
#L567

Regards,
Markus

