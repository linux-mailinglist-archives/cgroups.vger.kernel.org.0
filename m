Return-Path: <cgroups+bounces-13521-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEWpDAexe2mSHwIAu9opvQ
	(envelope-from <cgroups+bounces-13521-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 20:12:07 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FBB3D35
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 20:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40D93301648F
	for <lists+cgroups@lfdr.de>; Thu, 29 Jan 2026 19:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32029311960;
	Thu, 29 Jan 2026 19:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u5gHoOdG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D5231836
	for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 19:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713924; cv=pass; b=TNRsJXOwg6l63PmQcLTtmWiLVTa2X5VawjwH53DhycY7SZl6pru+yMGAlS/hx+a242m2Hfid3JwmT/mNHGqJsNwFE4wbCIsqCuP2Pu5Hun94O+3AHTO8CVzZ0U0t4T51gXjZn/8vRn9zA1wyQ7MymZLGiMZYqBReJxfukakrfCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713924; c=relaxed/simple;
	bh=yc52hjGkzZ5Tm2VKtjUQwD03ntP/HPo+QsVMLQpBmME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=hIrBMk78xiMfEBzr1ALnj6UdVT9+W3qzgBDlG3cQB0LnWU/GgJrYAbLv3xVtgoLBE1LB0BV37X6EnMswGXfI61suPrVWJXbMMzgtrI748DzABNACIjwwNxmQwVTGmu5wkKVtDc4VOZJ+FU81gO5YQkvZxTN9xd9tGxgkThV0Z6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u5gHoOdG; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4806b0963a9so5105e9.0
        for <cgroups@vger.kernel.org>; Thu, 29 Jan 2026 11:12:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769713921; cv=none;
        d=google.com; s=arc-20240605;
        b=cwqQAh43AV9e+oZnKzgEKQKdCVVM78LfxB1mffPGLO5/ye0gk8/ivQcLP0froAJf3a
         4ADPcgQ3Rg8Yhr0GtRMTP2fKdZz21isvA9t0L7upcFjSUdPFryfcRNWXo+vIpM8plzyz
         TVgIfuGhybvJI8GGLr2Pp59iEV0lDE2y59FWrh8IDEKFYn0bajN6asx5SxZ24uTWkCL2
         TlWjm+bxfqB4nMPRSNmK34kgQHe0O+y0TaGx/Ftxt16P5fwYtEapUkKdFYYSLD90n/AK
         +u2D9ZI1kdHFddD+Tg1maN1waiU2tB4zL/RzPolUOOUNjBQCkPDEjVgv38UHQkpJ5dXz
         A5rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pq8IaKrmDbwcHKyI5wAzPjbWS8D/qtr9VjRJFvUYIfU=;
        fh=jZkJrKNiGK4DJacBaBhGeapzU4+jpxPDUDY9puZVk0M=;
        b=OCGhcsDp28kLWRG9FT1A6AkehIkF+ZrdqRpaR/o+df6UoaScCW6Jo5PmVFUZLTMtN3
         o6Z0e+a940lucE3BmDrzt6ZczkvfiwXiCbWFYili3ckMUCydlU3+3x/walNJq9xEKHHB
         OslwbqTixhqWO/of9qa7DVPBEx3Q9wvO6mW7M8/bKvUpAsOCyC8Im971QSOwhcBD6h6S
         dk0NoUP0yKqPcZre76S8tRilRBooYwHvTGmI5fRRlr2gcQgIGAL7k93e3MPkcwhNR5fY
         MTwUG+rHrcSG/wKZxY7qlLNCqc4x7/K3MWrsyfsihHJNo6G29k1Zwp9LJdKeKEaZvrc2
         bvpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769713921; x=1770318721; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pq8IaKrmDbwcHKyI5wAzPjbWS8D/qtr9VjRJFvUYIfU=;
        b=u5gHoOdGQv/t9W24Pb3QXnGgJ5YHbNyy1S7OQI2Iv8cffoxBuKI5Lc/Y/5rAIFP8Uu
         lDNPGYznHVwPJsaNZwFWIQie+wdmaC0f167pQaqAzG0FOcxYXgeGIXdGY/vu8r+ZePKW
         7348yNRuEQ0B/YDMsxc/fNR2+l96GOMRss+TgrNFUOi9/mI14mPeKYNU1Ik9Vd2g74ym
         mmRK19ToQr5Mp0vkH4VtQQRro77tI77cvfBdgDCRUwMwxrJBj1WB+OskjM7moF/jlaCi
         wzSm0sPB4NSGBw4/JQCT2FCEN0BqpN/gi7/WOtRB6zg9wxjelrLXkiAVGAPpgm8JGW0j
         jYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769713921; x=1770318721;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pq8IaKrmDbwcHKyI5wAzPjbWS8D/qtr9VjRJFvUYIfU=;
        b=FP80/WQcbPFPm9EYdMX5cQqRiC7EvyvqqCxufk8c5fwdtvbCS+9gRUe6VowpCE7f+1
         KjG6D5JJB6a/rIhiVjVl5bBwoqUZmP4vZAbDxNdrEYMICUxKgLpj05zUKphqAPbZHTBA
         xg4TJ2+k6OYwZNt7DFO5oNS90KNfKfsPJhs2FzX5jpc+hV/tUrruX36e+oVC5m04JZoz
         2m6lcG9mK5jyINOr8GJUv7IkElUx/44M6XvEUp2JypGhP96YQ1RnmKJDh4FDT892AZ86
         Ti7IA78PK+818OtiSJQO4G6ajkHw0OAozIJ9eqnt57mm+ysnSzQOK0SXQKrcY2i6Kx1P
         KXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWzz/SqwzyKg62NUsjzGfEA/bJJCqj/miZ4V7WYNMCHHXaBV29wFoCIyJPuMla+pXkVE/mujP9@vger.kernel.org
X-Gm-Message-State: AOJu0YzBBoYqWgNZEqPIVzonE4POYvliGBs7d/SU3r3gRGtsHw+WzQTd
	gPLYVHr5YKc6nzygYQbRh61kOdW9qEG5jerZrS8EM6OudlB8OHLFi71KItSo+6vIfrbjSUC7c5Q
	HULPYkzFFzdCUbbWNYntiH+lIctWoPFa5AfryD8IBUSjmt2Ycj7zhpV3TBgQ=
X-Gm-Gg: AZuq6aJnZAw9Vnsc6JIurzI7ysjgnLVR3joY4oSOy0esH1+pwXN7EG7jHOSjzX+y7aB
	dUnem0NjAHb/y25/TG5O/j7PrLBUxoicff9g9IWF3HwoLJZYXuir9jxpCNLmm0g+G2GZ1Nglu1S
	kWaVAXFLpuOb5xc4/vtGMs4VLoDZq4b/K1y5Ad5alfeUe/gJM4BKuqGQfUJ2ZEGnziPkO4nyBLr
	YmJyp0ykEUUbqeN6AtFULrW96wJR2TpBAA+WV56DhcZEmANlqY2zR7vKZRjQDM/CVj6+66OkF07
	Aisf+PUQYWUue5NFVwIz1cGaVW0O+5L7DsWJtEaWj0m+snfaL3NEMmr8zw==
X-Received: by 2002:a05:600c:4a21:b0:47e:d98a:b8f8 with SMTP id
 5b1f17b1804b1-482db4b95d0mr22465e9.8.1769713920885; Thu, 29 Jan 2026 11:12:00
 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260129191034.3181412-1-tjmercier@google.com>
In-Reply-To: <20260129191034.3181412-1-tjmercier@google.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 29 Jan 2026 11:11:48 -0800
X-Gm-Features: AZwV_Qh3f5iIw7mra1yd2db15YJhi7znzQ9dMp1rY2req_9Nav5G0jgS4pMiMy8
Message-ID: <CABdmKX3rhV-Kn7fMg689Yo2M3f88xS5BxK+5R6G0-rEx9thBOA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] cgroup: Fix kernfs_node UAF in css_free_rwork_fn
To: stable@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com, cgroups@vger.kernel.org, hawk@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13521-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tjmercier@google.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 990FBB3D35
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 11:10=E2=80=AFAM T.J. Mercier <tjmercier@google.com=
> wrote:
>
> This fix patch is not upstream, and is applicable only to kernels 6.10
> (where the cgroup_rstat_lock tracepoint was added) through 6.15 after
> which commit 5da3bfa029d6 ("cgroup: use separate rstat trees for each
> subsystem") reordered cgroup_rstat_flush as part of a new feature
> addition and inadvertently fixed this UAF.

I am proposing we apply this one-off patch to stable rather than
backporting 5da3bfa029d6 ("cgroup: use separate rstat trees for each
subsystem") and its fixes to 6.12.y.

Cgroups folks, please let me know your thoughts.

>  kernel/cgroup/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index b8cde3d1cb7b..cb756ee15b6f 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5481,9 +5481,9 @@ static void css_free_rwork_fn(struct work_struct *w=
ork)
>                          * children.
>                          */
>                         cgroup_put(cgroup_parent(cgrp));
> -                       kernfs_put(cgrp->kn);
>                         psi_cgroup_free(cgrp);
>                         cgroup_rstat_exit(cgrp);
> +                       kernfs_put(cgrp->kn);
>                         kfree(cgrp);
>                 } else {
>                         /*
>
> base-commit: abf529abd660d8ccad46dd8c8f20e93db6134f5f
> --
> 2.53.0.rc1.225.gd81095ad13-goog
>

