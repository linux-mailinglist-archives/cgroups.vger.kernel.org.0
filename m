Return-Path: <cgroups+bounces-17153-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uMEhG6ewOWpzwQcAu9opvQ
	(envelope-from <cgroups+bounces-17153-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:01:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1836B28C4
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 00:01:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel-dk.20251104.gappssmtp.com header.s=20251104 header.b=m4mbs7PO;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17153-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17153-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6749F302D500
	for <lists+cgroups@lfdr.de>; Mon, 22 Jun 2026 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8673836B07E;
	Mon, 22 Jun 2026 22:01:05 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E451D9A66
	for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 22:01:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782165665; cv=none; b=S9tbEKyCZz/40Y7ZEKJGwzQoFAXYrVhe13nztekum4KZI2bFc7K+JJXBWF3Vt3k/tdO4aE8kxhBQZm/I42vpRt/C6V+JTk+aRvcZ5LUMi3X7FJBXXupgFL4WxYL0NulCcoatXygWDV17qxrn04UiQXjWXVIXox/KrfDXgb0588E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782165665; c=relaxed/simple;
	bh=8iCisRkHV3+0EN6bso2f4frYm0nmJrhWJ9IbZh4Lo9w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WqQ6w/sKDvEWkdnHPPhOKs9jubIXXhSreyQqMxBVC9DQKdby0IE+At5JzSH3K1dulvs7Lj3HJEbsR8sj5BgfoZ9MzTrWg6RmgQpJYubJQgUno2DdcDu9gAnfBXuA2RpeJMwxwm+dWRQr2ray9eQnxkXoEUooXLMnuqCz4FJICe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=m4mbs7PO; arc=none smtp.client-ip=209.85.219.48
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8dd74f90e3eso56044816d6.2
        for <cgroups@vger.kernel.org>; Mon, 22 Jun 2026 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1782165663; x=1782770463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14xOeLEoF1fHcF3BjkYbSGPbgudDiHstM/8c5Hb9SBc=;
        b=m4mbs7POaNoCQFs1WgrrGgRpIyRnmgRWnmv/GIAQ6BzLBsVJ7Tz3n5wcUmFHbn/3tG
         9+vIlYOHZMH4Bsm42mKpbRa3nOHj/Sl1HQjPF/9CqT1c+WYmHYf3P53YJTgiXY8ZSkcA
         MF1OdV1fpBpNH7fBnyODEXFoe3hVuffDwgosrwtWrz7nXNUwwRuEgiWWfEmEPZ5CFIuo
         UdmAIwANwTkKxWW3dD2tp+2LL8qQWv6ZQZ2Ujg+DwuhkVkv767G6HRFZWfaXnc17p8TS
         BVQx4/3zJGolnwFYGsqdd+TUxIKpez4nKaJOoh+byN6dz/yi9gMEwJVi5sDIyS5HBBCZ
         vnAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782165663; x=1782770463;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=14xOeLEoF1fHcF3BjkYbSGPbgudDiHstM/8c5Hb9SBc=;
        b=ROniNnoy0q1XapFYZgGB033Yko+kpNj+6Nilrh+xwcx1TToyBBBsEmIrgebQh7djVU
         EYTDNdNgMZdpWyfC+tKYdATlAdOypamYqtD0PFI0L1TmSF+tn4fFMuZHXvXrsk9q/kdY
         xOGS4VPwdG5Mf976ERxco2R3M9HO6hq9xI6gwnVMleZzN2seYhd0Dq13IPJ09sZMjuDN
         WLN+SVu+IeKzyHoKffRienIrfSsU9Ie4tXS/t/7Oi8O9qmIqp8X0Ge9wg2t4s3U0Ygkk
         nML7zC7DKtLilsAOzkVnr/CJIjFhoeD7ZAhBmKBM4ufvgzj8u48FAh12wqsxA0hv/aYJ
         uPpQ==
X-Forwarded-Encrypted: i=1; AHgh+RouhWfdFASCTWuwfjRqrU5qAJtQ4ZoN/ZGLdDJkn2XGvHOTJ3DBMth8PAI+ZWF/QxL10/QFVw2D@vger.kernel.org
X-Gm-Message-State: AOJu0YyYrIM8bfZI9Bz5/dWGRY9mEZ7NL39plyvlM1hzoF8Qd/kcHXfO
	M/WrQiMCUB8t1hMfGGVtXKh8vt1XcoYtyWntxHvXAb3/2xjTC9ID1ZLDtWb/cRtCPH0wIEVPaZy
	9A1OM/Ig=
X-Gm-Gg: AfdE7cnmPNHYt8nwy2vPAwKylmCP1cVhc8XnnjS1TEsNQn0TaK1U3qnnmLL6sKbX17K
	tQf0KauFQ443H0RNWafA5u3NwOeG7/lMG428a5+RrLsciQ2zD8IRnHLYwWAngIO9ZABCtid6ZIF
	j94zqagN0DgiExoCyHUlQXqiuXx77v+g2B/McRVmux9b1PnJjQ4YcxawZWdyTD/83CofDKsnP+k
	QBmkFSmzQROo/RR+2lAjjzI2VjPAl5+t2VbfM6ByX9+u+rCCV/nv5pAIxjiiAZp1d6XMAaTkPfB
	gDOOqXNKAB242AL0okM2rrWMSHdSfS8TbsQjNsYf0jt8/GjPlbJ8Fy7qrC835dqVdgHDw4R10cm
	XALG7COvk8XFAjdio8GumMoEodfGEVE5I5XW83n3JEibV1jdKE3iqPXYvect+bIaIr1C/ybaiUg
	b7KpibLgd69Qk0j05qSlr7B34zm8gLrn/Dwho=
X-Received: by 2002:a05:6214:488e:b0:8cc:d29:9f78 with SMTP id 6a1803df08f44-8df8f90f599mr233832156d6.11.1782165662719;
        Mon, 22 Jun 2026 15:01:02 -0700 (PDT)
Received: from [127.0.0.1] ([99.196.128.58])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df7f018898sm106932496d6.7.2026.06.22.15.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 15:01:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Yu Kuai <yukuai@fygo.io>, Tejun Heo <tj@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, 
 Arianna Avanzini <avanzini.arianna@gmail.com>, 
 Paolo Valente <paolo.valente@linaro.org>, Cen Zhang <zzzccc427@gmail.com>
Cc: linux-block@vger.kernel.org, cgroups@vger.kernel.org, 
 linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
In-Reply-To: <20260621135930.2657810-1-zzzccc427@gmail.com>
References: <20260621135930.2657810-1-zzzccc427@gmail.com>
Subject: Re: [PATCH] block, bfq: protect async queue reset with blkcg locks
Message-Id: <178216565206.110437.6768049462102917317.b4-ty@b4>
Date: Mon, 22 Jun 2026 16:00:52 -0600
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yukuai@fygo.io,m:tj@kernel.org,m:josef@toxicpanda.com,m:avanzini.arianna@gmail.com,m:paolo.valente@linaro.org,m:zzzccc427@gmail.com,m:linux-block@vger.kernel.org,m:cgroups@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:baijiaju1990@gmail.com,m:avanziniarianna@gmail.com,s:lists@lfdr.de];
	DMARC_NA(0.00)[kernel.dk];
	FREEMAIL_TO(0.00)[fygo.io,kernel.org,toxicpanda.com,gmail.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17153-lists,cgroups=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,cgroups@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernel-dk.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C1836B28C4


On Sun, 21 Jun 2026 21:59:30 +0800, Cen Zhang wrote:
> Writing 0 to BFQ's low_latency attribute ends weight raising for active,
> idle and async queues. The async cgroup path walks q->blkg_list, converts
> each blkg to BFQ policy data and then reads bfqg->async_bfqq and
> bfqg->async_idle_bfqq.
> 
> That walk was protected only by bfqd->lock. blkcg release work is
> serialized by q->blkcg_mutex and q->queue_lock instead, and
> blkg_free_workfn() can call BFQ's pd_free_fn before it removes
> blkg->q_node from q->blkg_list. A low_latency reset can therefore still
> find the blkg on the queue list after the BFQ policy data has been freed.
> 
> [...]

Applied, thanks!

[1/1] block, bfq: protect async queue reset with blkcg locks
      commit: 17b2d950a3c0328ed749476e6118ca869b3ca8b5

Best regards,
-- 
Jens Axboe




