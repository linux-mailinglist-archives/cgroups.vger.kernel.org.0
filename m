Return-Path: <cgroups+bounces-17775-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /EwsFEYgVmoTzgAAu9opvQ
	(envelope-from <cgroups+bounces-17775-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 13:40:54 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2385753F9B
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 13:40:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GEDllHkM;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17775-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17775-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DB64313F495
	for <lists+cgroups@lfdr.de>; Tue, 14 Jul 2026 11:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C5F381B02;
	Tue, 14 Jul 2026 11:37:59 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5F6351C25
	for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 11:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029079; cv=none; b=oJv0mRDoYm/RNkOQoDTa6NGd4hIAfPhJJa/qPg3VcIJJ60NbLiFbrZPMYTEw5hc57cOSMOxrKBbUWWSzl7PvWDg/09Lx4TCpfC+X8m2tRvmFIj/hUdxAicD30r+IFfWMSYv7QiAE+Yaw0kdZQNcndfsGfciQFE0iY9QZl39iQSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029079; c=relaxed/simple;
	bh=jvi/C9nTXOmhhjc0Lb9aktYocYiVVnB804trf7lfPrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWDTWZxX0Dif/v0WdOjT5cZYQ0x6wU2tByEVaRoJl02EnuAgKlECvuivAqM89yGYMhPPoZmXjU0qkRkOqkXAKX3120yLv1BL2Cubss8odf7hWkr8Z8YYyjtVJDmBFlsc+LGvdyV8krTXM+tXxXYQIk3CCZ5p8OaqrzjAFyp5T8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEDllHkM; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4728c12ba97so1853691f8f.0
        for <cgroups@vger.kernel.org>; Tue, 14 Jul 2026 04:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029076; x=1784633876; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b41+ZmPO1kjwWz2S29LAqh9eI9JWVyVGFI2NWPufoa4=;
        b=GEDllHkMR41S+dFNps77d42LYWFFvUETZcKa6lXe5Jznb1xNebSNVqjLBft4ultjhH
         qPDxg6pt6SzoDx06feDSqLh/R/K7JoAPcsjhcb5xP4Z9aHTtsfihFjuMh/JfMN4WLDNZ
         R9oKnySqSg266qG6syoaTLWYm4rD1FlA5PcK0holyYlTikmax3zsgTXs7Zi5uLiG8nGs
         jcKJBg2m0W4fb7Q3uk4qkVbyYvKB9be78gNuSW4O/uFxwxDKmalSJYbHlVhcUKGo8MBo
         u5+gwFL/wAdlaKM2RYh+QyfMAASBhfJf8BvWMSjIACaGt4mBpYCGmV3Fra+To33aBy7H
         Tt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029076; x=1784633876;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b41+ZmPO1kjwWz2S29LAqh9eI9JWVyVGFI2NWPufoa4=;
        b=kqXdk6mLRsS6k9Yt4tT1nOU8p+0XxBC9cvkE3vQcrgoTPg3zF9MDcMqAOd6GtUj+dp
         nR6MYtEb23PVHNAmfBTLfOBnfJJ3ZWl5tFG+YwL/TVSu/u5z4fpTdU5xXURoNVeNfTfI
         wmrGOwm0thURuZyORcNuEFLIWO1WJQSzUpBAdGu373bqwRAlivwz3se5iHKrdgXnffK3
         pxb34mgBiFO2ZdJ+ZMmRC8VoEqGyoxi2fI1mwyp0q7PMLuOZ0jgs7KHIYirP2smEpGUt
         sn0v5DdTkGyoeTxb1zxkHTjPhXUbFbQ1/JU9wamc27O6O3eH9872WRQhavzV+WyHyOTP
         t+uQ==
X-Forwarded-Encrypted: i=1; AHgh+Rru3YvrGoGeG1z7k2HDxlDk7QFXMiz2UBYCIhJgS4tE3XN4TvIPRzJ6UCreDXGVeRQDnpSvEEgc@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUwL3RPF1thQaV+7udlILJnBf2K7vEfRxOyzIMxjT60VytwSD
	2St/np1+t+I+Hm8agmZeauJLu2wSQwcZ1v6URQ6UmC5oDlv9VTS0WwLB
X-Gm-Gg: AfdE7cn91qQh5vfNKOhJg/yh5kVxJx7UQu73mZPuhFP/KT44VPc+L+ULzeG3qAzmL6V
	yzSfej/hVM3lsJmlYMyfs/9LJhZdb77xSR5JmVckBYrJBk6+4m/l9j32dV4iHY7R7iyUMEoTHMq
	vlVxIedQadhc3N+QnGKJijUxZdHSVOEtC25Jd2iB+1HfY523G/2YInxYZ24MlagP1TBllZ9U0bL
	WpwcyLfPADUSS83Tgh3a53kZK/4SpcjKDZDdJioMnYkuew5J6qIedF4hGEOrQ28bOr45ugvBD3T
	K02RKgwfZLGaZ/hOiPEWXwaWInWybEZxmnleFDEHJfphxV4Sk7MTSEh+hLRFktTefk8E2WptWcZ
	S7ctHBJGw332rVQ1Voo3MgP2eyi4jc7Sq80IqZPRniijwYhJJgcQNjF8TsXULabGQ8CoU9TWH8F
	fF9hTCKl9r/Iu/I8+s7hkrtT2KZjwyIyKm5scm4V4Rs+Q9NHIwsA==
X-Received: by 2002:a05:6000:240f:b0:475:f0f0:9f01 with SMTP id ffacd0b85a97d-47f2dd05108mr15393267f8f.56.1784029076179;
        Tue, 14 Jul 2026 04:37:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm7440719f8f.37.2026.07.14.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:37:55 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:37:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: axboe@kernel.dk, tj@kernel.org, josef@toxicpanda.com,
 cgroups@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] blk-throttle: fix divide-by-zero on legacy iops limit
 of 0
Message-ID: <20260714123754.7a88a65b@pumpkin>
In-Reply-To: <20260714103552.1335658-1-cui.tao@linux.dev>
References: <20260714103552.1335658-1-cui.tao@linux.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17775-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:axboe@kernel.dk,m:tj@kernel.org,m:josef@toxicpanda.com,m:cgroups@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,vger.kernel.org:from_smtp,pumpkin:mid,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B2385753F9B

On Tue, 14 Jul 2026 18:35:52 +0800
Tao Cui <cui.tao@linux.dev> wrote:

> From: Tao Cui <cuitao@kylinos.cn>
> 
> Writing a multiple of 2^32 (e.g. 4294967296) to a legacy cgroup v1
> throttle iops file (blkio.throttle.{read,write}_iops_device) silently
> truncates to 0: tg_set_conf() stores the sscanf-parsed u64 value into
> an unsigned int field with no clamping. The cgroup v2 path,
> tg_set_limit(), already clamps the same kind of value with
> min_t(u64, val, UINT_MAX), but the legacy path never did. Note that
> the "!v -> U64_MAX" mapping only catches an explicit zero and does not
> catch a value that truncates to zero.
> 
> With iops stored as 0, tg_update_has_rules() sets has_rules_iops[] and
> the next IO reaches tg_within_iops_limit(), which computes
> 
>     jiffy_wait = max(jiffy_wait, HZ / iops_limit + 1);
> 
> triggering a divide-by-zero oops.
> 
> Fix it in two places:
> 
>   * tg_set_conf(): clamp the value to UINT_MAX, consistent with
>     tg_set_limit(). This closes the truncation root cause (and the
>     general silent truncation for any value above UINT_MAX).
> 
>   * tg_dispatch_iops_time(): treat iops_limit == 0 as unlimited so the
>     divide in tg_within_iops_limit() is never reached, defending
>     against any future path that could produce a zero limit.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  block/blk-throttle.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/block/blk-throttle.c b/block/blk-throttle.c
> index ffc3b70065d4..3f3c1374f4b2 100644
> --- a/block/blk-throttle.c
> +++ b/block/blk-throttle.c
> @@ -883,7 +883,12 @@ static unsigned long tg_dispatch_iops_time(struct throtl_grp *tg, struct bio *bi
>  	u32 iops_limit = tg_iops_limit(tg, rw);
>  	unsigned long iops_wait;
>  
> -	if (iops_limit == UINT_MAX || tg->flags & THROTL_TG_CANCELING)
> +	/*
> +	 * iops_limit == 0 is not a valid limit. Treat it as unlimited so we
> +	 * never reach the HZ / iops_limit divide in tg_within_iops_limit().
> +	 */
> +	if (iops_limit == UINT_MAX || iops_limit == 0 ||
> +	    tg->flags & THROTL_TG_CANCELING)
>  		return 0;
>  
>  	tg_update_slice(tg, rw);
> @@ -1386,7 +1391,8 @@ static ssize_t tg_set_conf(struct kernfs_open_file *of,
>  	if (is_u64)
>  		*(u64 *)((void *)tg + of_cft(of)->private) = v;
>  	else
> -		*(unsigned int *)((void *)tg + of_cft(of)->private) = v;
> +		*(unsigned int *)((void *)tg + of_cft(of)->private) =
> +			min_t(u64, v, UINT_MAX);

The LHS casts look horrid - there has to be a nicer way to do that.

And you don't need min_t() a plain min() will be fine.

	David



>  
>  	tg_conf_updated(tg, false);
>  	ret = 0;


