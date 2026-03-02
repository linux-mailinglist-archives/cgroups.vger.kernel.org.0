Return-Path: <cgroups+bounces-14525-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIX5OV/opWlLHwAAu9opvQ
	(envelope-from <cgroups+bounces-14525-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:43:27 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB4B1DEE9A
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 20:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ADA6B3004603
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 19:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C147D957;
	Mon,  2 Mar 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="PoiIcJ1l"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219F447DD54
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772480600; cv=none; b=u9FCx0EvdBdgedAcMWtn+d85KwBE7WYzjoPkZ/zhn77FqVmLdDJ9ocpH1t4YRTU7R8OUuYmH3CmoQFwAQw/i3VkgaXoy86F6B88sazFEJdPdA5v7ju1lbO21RBiYy9XJsyIyFCfhQEkG1oKlXHhJzxupWgU8FACkPF3b94J1fFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772480600; c=relaxed/simple;
	bh=4/x0M0Rbx6RmvF903a9JQMm6Izl2eX8bg8z2bTX5014=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzh5mViGr66MJyfLj/1hmpoO5/hj0HpPi/6m5xL07WCv1a53l+P1yOHnmhhFjxifsxGLG+UNxToW2/unwiovjVFxFy9U6AAg43v7muNcx3FcFG65FfPpDc8J4LwvOqmjGn1hbzvl9DBfsozT1zbHnfrbCeK3huqKFnfRygSANEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=PoiIcJ1l; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899d6b7b073so42526436d6.2
        for <cgroups@vger.kernel.org>; Mon, 02 Mar 2026 11:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1772480596; x=1773085396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xPNnWZeU91X74vtWviIJ0traba9XBufSLH0afVq6V/0=;
        b=PoiIcJ1lORdFy9E4MjdS3qFmf4mJdV30foD8rbzqCY0xMzk3Hhlap8NoH+odRMy3ah
         o+yksMNLwKeTY1FLQOOpf2ONBI0M6AIrzdXpj00Qupz8KLP9MQgUCfGHeto9/CjMvNwn
         qdUfZ6yzC/eHW8Ucdh77lpidSopX//39sy0aXS94AolgekYorxDEoarVJISsTSnTo6Z2
         djhYAnd957FWTsqLA6HQ6fc9cplX7b6z76wx8FfPRLAH5LGd1hkqJ/5KHf0s/05dyymX
         kClL1RYhhith/wVMLgbwM7dgKSEQMTPpYLVGYLOdTydiBExzsbNu0BkDGwEXgS4OLgQe
         ILzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772480596; x=1773085396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPNnWZeU91X74vtWviIJ0traba9XBufSLH0afVq6V/0=;
        b=b4h/mAQx31UQfV2M4OFecEd1H02YFgNGsP9hlBBdsBYQkFxQ9yBjALQ9GfelO5goot
         HoztBl7/L47GZ0bhDSdSDCnLLwWcaGtgYRLPFyiaAaBmP7GizzAjWkoBCM6g1QXt7ksX
         TcCW0dEdUQcukNKEgeFC04qzQDUNfMd1kY8kxHVLBrQxFAGd3eARQMGmlzOHTbM1gU4N
         6KmNtI/IohDGuBo0K+zvIgic81IFDoS+BMuEO9Y/BBkDQyuV6j1uqubXkW1xRsBo504V
         s75Us1qscvzH4PCmcNcswX4kxXjX8NxA5z+pg49+Qi57CmfS9ECQ1jqdFhuCUBcbDaOq
         Yv5w==
X-Forwarded-Encrypted: i=1; AJvYcCVFBHHrF1wKo273XbGhZyXdZ9iW0+zh75tVEysTPVcCMuN1UiVI4lpg2PozXYeu6QntCdqnOF/3@vger.kernel.org
X-Gm-Message-State: AOJu0YyRfX7UPX9T0A56zI80u+bUcC8rdtLa7h6EqUkkQKaIUQWHZHeQ
	H9AUmS9ahnBCgugWiQIYLIRfKECEy2a4A+LG046ecj5srjKBEw++a7wxiOIbyI1vqI8=
X-Gm-Gg: ATEYQzwGmm2/aGqz3U0K94jyyuEK+PaJa3+6SQJThuLk82Tm+45ryBsJjYjLEh9snKB
	eHxL3LKrSoOltqBKwVjcoUUPcbwY6GOqgj42N7nGhN0qwg5ihHsELEy4dmuFGvMcUZvtvj+XipL
	j5QzByk+DgUlUm9qZQbnPunu4PqBWTCyTJBChSvozOIjSfTjFT1b8XTdG/wxbuWrAi5jTBZiIVs
	ZFuuLWzrHOEYMpG74liLL6CxRDwjb3IqIMaHVHO0L2WtK/9S1Aq4RjFxf3CvMuNHDjJWBO06FG1
	Wk+zNKKJ8cAqe9gVewYylx8P47+KraF/lpbRW8Psyt1WZALPPnl1NB3WkJlVjmn2UPGNIGBGZ7G
	WgOJ9EPVLAE2/M0870rnD0/0aMWb2qZNMqcJKDJ/WNRwFz5LwIM+kAAaozVi/BlQLhYbm6r9jS9
	LFXEe724MPSvVLgsgma0cKfw==
X-Received: by 2002:ad4:5ce2:0:b0:89a:929:9e4e with SMTP id 6a1803df08f44-89a0929a5f6mr1131166d6.14.1772480595638;
        Mon, 02 Mar 2026 11:43:15 -0800 (PST)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a083a95fbsm3727846d6.38.2026.03.02.11.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 11:43:14 -0800 (PST)
Date: Mon, 2 Mar 2026 14:43:11 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Jianyue Wu <wujianyue000@gmail.com>
Cc: akpm@linux-foundation.org, shakeel.butt@linux.dev, mhocko@kernel.org,
	roman.gushchin@linux.dev, muchun.song@linux.dev, linux-mm@kvack.org,
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
	inwardvessel@gmail.com
Subject: Re: [PATCH v4 1/1] mm: optimize stat output for 11% sys time reduce
Message-ID: <aaXoT17JoTv87l40@cmpxchg.org>
References: <20260122114242.72139-1-wujianyue000@gmail.com>
 <20260123150108.43443-1-wujianyue000@gmail.com>
 <20260123150108.43443-2-wujianyue000@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123150108.43443-2-wujianyue000@gmail.com>
X-Rspamd-Queue-Id: 8CB4B1DEE9A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,linux.dev,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-14525-lists,cgroups=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,cmpxchg.org:dkim,cmpxchg.org:mid]
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 11:01:08PM +0800, Jianyue Wu wrote:
> +void memcg_seq_buf_print_stat(struct seq_buf *s, const char *prefix,
> +			      const char *name, char sep, u64 val)
> +{
> +	char num_buf[MEMCG_DEC_U64_MAX_LEN + 2];  /* +2 for separator and newline */
> +	int num_len;
> +
> +	/* Embed separator at the beginning */
> +	num_buf[0] = sep;
> +
> +	/* Convert number starting at offset 1 */
> +	num_len = num_to_str(num_buf + 1, sizeof(num_buf) - 2, val, 0);
> +	if (num_len <= 0)
> +		return;
> +
> +	/* Embed newline at the end */
> +	num_buf[num_len + 1] = '\n';
> +
> +	if (prefix && *prefix && seq_buf_puts(s, prefix))
> +		return;
> +	if (seq_buf_puts(s, name))
> +		return;
> +	/* Output separator, value, and newline in one call */
> +	seq_buf_putmem(s, num_buf, num_len + 2);

You seem to be losing the \0 somewhere. I'm getting garbage at the end
of memory.stat on mm-new:

  [...]
  thp_swpout_fallback 1212
  hp_swpout_fallback 1212
  hp_swpout_fallback 1054
  907
  1278

Dropping this patch fixes the issue.

