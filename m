Return-Path: <cgroups+bounces-15779-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHz2CyU0AmocpAEAu9opvQ
	(envelope-from <cgroups+bounces-15779-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:55:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F566515536
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 21:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 754AA3050A6F
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 19:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A64437E2E4;
	Mon, 11 May 2026 19:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD4TJV8f"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A237E2FD
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529197; cv=pass; b=cLW1hdDq9Y8QouWkzPcoexhH7pM9CD1InYhoZjfiqMBdf3yMEr6+rjp8U81q3Q1N6ZmtCwNYFikwdgek/JfMNeETRrtCFk9Hv3SRpG71iaFvIYvWmbuzgHvlLZdB5yxn6rEPZbjwiCcX4Kku725c4vfldww3lTiT/k/ZEJok1eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529197; c=relaxed/simple;
	bh=ZP7FByjj/MPynW/2rM7ALpiB4VnbDXXIxz16fcl4k6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTc+XzcVU9JWnTTqubM8+LUTn7/UVW0QbHeiuv25EowoVP39FV8vfpTLeT6jw/PHs1hbw86QG/3W3L47V4yOkgYtY/snSgTbcKMC6vJbueVtwRLpgoFRRRMG7oy0HEUqxlgfwSIKIuFujW2+XpJlUU/LeMb81r4s/uwMjaFdbPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD4TJV8f; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-448528f4e69so2819474f8f.3
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 12:53:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778529194; cv=none;
        d=google.com; s=arc-20240605;
        b=Rxp51dcebFkiXmm8UxxvGh9hvP009Mqz9KXFZ5vhWBdAZO20LjwwUrU0GrKeI9rVxb
         mhMFuRUSc1qlbkrKNmdxCRz+lL2/D/zTtWINxL6GtAAzD5Oa8bLpFJeix+yO2B3AO86z
         rooPGNYFokuzEOiljEDonf11DtXaqR2LXTpzaULRoWqBNY6UyLY+GMlYdEXLPE1Jv8oI
         hoRiJVSZv1IcKX+XFxtuqSN03iPpN03ur3K6lvHrj1GSNX9kYVFwNGShXeUPHx8xFmDc
         ixwWEnY/uJPNbyLg4k1kJv72Dlrsn9dtruCueLRY5pMiWbRi4i4XnTCL6VVnddMe1hSC
         TpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZP7FByjj/MPynW/2rM7ALpiB4VnbDXXIxz16fcl4k6A=;
        fh=NzA7nKKW/1Y7PvwqjUvDTOo7YUHBeFXkzFVDZ+Tcfls=;
        b=TEE9Mgvb9hRVnSB+Icw3/LAU3pYujLbpNOgN+MKHw1S30+AurZNky21Nuf12HIWbys
         NGB6JrTlDHC3Fx6/OHnsazjT1GuTIpHhkeUQ4mQSp7Ul4A0TWyorwLscM3GuB3MGi0yi
         8iphWItdRF++72ouHZcr0VH7CYfO2E2NutOtlz3xso6y7VEXGdlC9QjXKb5gLyRpsoU0
         7imzt/2qEOqQI8LRGeZMj9OXqIeR5J1dajOfHYQ1FDgcEY6KFPEcsZuBhFBrDGpZf+zq
         9qb+WRd87srt0Yjzkq1n/ubEI0LbFEXaHdyjLNHhX2Iyjm9dN5h6Bp7WIAMtleBhk4cB
         Onlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778529194; x=1779133994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZP7FByjj/MPynW/2rM7ALpiB4VnbDXXIxz16fcl4k6A=;
        b=VD4TJV8fHvDHAiNK3DcfIjLsbvDoasNFsLe4HGrZiThE8nYkoTxUUUJYPTCIW4V5b1
         aRFk2S8etFHeaxdz2Ulym1JRC9sP7s3nspGPfM4sAK/q3XqdCjk8WXNrjhT3RKj3w6PV
         +yfqjOhrx+bIWsburYF8nzV3wjpjVZWpvT9SvS4fmIFmNqVD4VFcnJyGYU3ENzzdDEr7
         68/GJ/ccmh+6HT6VgYqgNMizS2z0Cto8Z2uOtfvtPJ4RnRx/dpn959ExoaiaNGPi6cGR
         vmXFXoPxAKowgglBKMIeJlrfmY38MqcFdQtJ5+sMicQJHIBF8AZSyux+eYjfib0FliR+
         OLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778529194; x=1779133994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZP7FByjj/MPynW/2rM7ALpiB4VnbDXXIxz16fcl4k6A=;
        b=Islf1FOF0uzJppDN+kBYhus+KKBqo6OGZAsd9aSCzdALSH1DBDJCV2zXrCqlLBAFsG
         R3u1Y/j8cKQX7Yl60kVR7UCUdV3HkzOwKlBX0LLuy1UK5g7y6bVAcuS/YMr7DVT2PnMY
         wcdDRsQAwmwU8P+OZx63WGsAvanfAbSsWxTcRu/SxQApJxGL/2tie+q9e3nx385nhN/h
         /CXoLWcZq6AfkSLdL1c6WxFX1Z18xR8DNlDJaO8IUhZWV9I6gW3FsdYMgR9eRkEOOn0l
         we1LBWWWHq38kndJB5snWwsenDrgLbz/8evQT2f0PLFsgpfiWQVK/rJ44eWTtEIXzEUp
         6Nnw==
X-Forwarded-Encrypted: i=1; AFNElJ9vs54V2M+Vz50xhCXJ9U2bGTQvWtlE8xUwAI3RZD0dRucERGQ6qGyZwZr7MOnGZ87LwqNGhtF+@vger.kernel.org
X-Gm-Message-State: AOJu0YyhkV68dz6FsWDSUraoXINvEJao5+DJIjFaZkHstzM07y+TVmtA
	/8e/5tfOhX9OO+LefV1yZUE4p8BEFEpxd15X7k7S7vqey2fLH/HCtyk4SLQAnvMS9+EjAwDRyWv
	eSPuIXyWyuUqYU3Wa+x49/eDRVs6UoeI=
X-Gm-Gg: Acq92OE2ok6o0wGpiyrqiHv1gIUhmDXpgyGNznbUwxVbp4BwaFXFo8trbkjqamCatQE
	kCW/Sd+g2TW0BE4J+qpr6lNTRzUWRNZh/bxpgk70k2rjHjmpyCczucN5xdUFPG0l8atI10NCCkX
	WUwN4srIR0DO7hna9CQvpBW+ME0qpr7tATZyU25reM0s+2VSFyJ2SOHaJ8G/fjfPqRkru2Vn9L/
	KFGd8G4fGYstL98kAx6RJ+db+oATCyCpz/aKwk/v5DXVORGG8FPhRRf5i/Xl8U4koCRTDub4RAC
	LxUz2uM7mbPgAtqzC10MXHn7O/uPbUyNT68FIEc=
X-Received: by 2002:a05:6000:1e46:b0:454:a41f:d082 with SMTP id
 ffacd0b85a97d-454a41fd125mr15238153f8f.3.1778529193707; Mon, 11 May 2026
 12:53:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511105149.75584-1-jiahao.kernel@gmail.com>
In-Reply-To: <20260511105149.75584-1-jiahao.kernel@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 11 May 2026 12:53:01 -0700
X-Gm-Features: AVHnY4IvNhdPdYI_KTABXX79UzLYn38l9ZW-nKKsalLOW5HyYORSIzprVHs4vdU
Message-ID: <CAKEwX=NqOzcbSyuipFvpPUrBQuB0mLBjoboM=LrijkZAfyamxg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mm/zswap: Implement per-cgroup proactive writeback
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, hannes@cmpxchg.org, 
	shakeel.butt@linux.dev, mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com, 
	chengming.zhou@linux.dev, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 7F566515536
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15779-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lixiang.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 3:52=E2=80=AFAM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
> From: Hao Jia <jiahao1@lixiang.com>
>
> Zswap currently writes back pages to backing swap devices reactively,
> triggered either by memory pressure via the shrinker or by the pool
> reaching its size limit. However, this reactive approach makes writeback
> timing indeterminate and can disrupt latency-sensitive workloads when
> eviction happens to coincide with a critical execution window.

You can make the same argument about ordinary memory reclaim :) That's
why we have kswapd (asynchronous reclaim ahead of time) and proactive
reclaim solutions (memory.reclaim), which would all target zswap as
well.

>
> Furthermore, in certain scenarios, it is desirable to trigger writeback
> in advance to free up memory. For example, users may want to prepare for
> an upcoming memory-intensive workload by flushing cold memory to the
> backing storage when the system is relatively idle.

Would memory.reclaim not work here? Why are we treating zswap memory
footprint as special here, and spare file and anon?

