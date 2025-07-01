Return-Path: <cgroups+bounces-8661-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3689AEF0AD
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 10:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA01B4A01FA
	for <lists+cgroups@lfdr.de>; Tue,  1 Jul 2025 08:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2B26AAA9;
	Tue,  1 Jul 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IdpTj6EO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C31426AAA7
	for <cgroups@vger.kernel.org>; Tue,  1 Jul 2025 08:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357785; cv=none; b=fJZrEffS+WbczZ1dpCohgX7CXdr0Pwktjkc1Qt245KgyVdEYYsR8dXkUkUJyvAs/5/AP8lzmMSFa7R9fyzjocoI7vpLOGrRfV0oy/Q/Kd7iKir8Hnho7OXDST7hBZlztDHw/Vn7MSU/VS0jpZHGm5kaGXLNbJ6sXTaYwiiaLckM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357785; c=relaxed/simple;
	bh=cqO9Gh6Ed5X3G7nZke8eswDnt3HZEzQjQs+HR2ju8nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYLTKhphVJa2ml5gyG/JNL+ggbLmxDC9RpE5taKk1CLfyKZmEde8/gYvO4kbTAs9JigAzdgOrOooQNzw2t7XClb6nysBYZMNh8DY8zQBjgJEkRVHgkTNW8bgkPUnZuLgIdiKS8DbuhUeQFNKQKbfjMYjwvRgL28Xj0HpujdIXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IdpTj6EO; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-451d3f72391so31074875e9.3
        for <cgroups@vger.kernel.org>; Tue, 01 Jul 2025 01:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1751357781; x=1751962581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cqO9Gh6Ed5X3G7nZke8eswDnt3HZEzQjQs+HR2ju8nM=;
        b=IdpTj6EO7dKRaeIX2pPDPl1m7V63kT+mGhavqnE5OiJq5fSjwPkLm15QAVQ0m8ZnYQ
         2SCyrbTT3GLraVq9Qa+E1pf5Mvy92xqwx3nYbZTJYm2r9V3pAlqMoz+h+vBhGD4G4F2U
         RzTy9EcZJLZRjMEkCLlUQLoJ+5APlyCf+WiTZ27zNXqRx3DA1LNagxnZVvjJqngudft+
         zpnU/JxICN0k3Z4umEgUnGWpm319AfUn/JyJ0fquAgWxrwuAKeMnxbVfI07LWqR5pUn2
         Mh9U2NgAwQ2tpes7J4Fy6XL4dqcKS4tqxjtIS4L9tsfW6UyJONSwFHrUStYbWBgsvxLP
         Q1pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751357781; x=1751962581;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqO9Gh6Ed5X3G7nZke8eswDnt3HZEzQjQs+HR2ju8nM=;
        b=iDKIXubLmlrr43H0j3oQCgHsVafmhoxxDDjq8mEXCCk1wfshP2XO/CVkWf82lBkrNt
         1I5oo+2HcbLGfjzwPQ/hwiAAa+45xs0HDlNvTy/6jvYS3K+0YoN8+fzJP1kk7QQGZ+eP
         WGLgPn/S4D9aXL4W5i7JvBvNKbFAtZYFmghsW+qvI/tdNG+5MwS9q0cMKMH63QFEJgI0
         lgEHAG21avs8ajMuUnMe0C3ocDw9qc7Syg6gG6xF0ph4PrIRh7LMavJNknyPrzG3LDZx
         mSqBm2JjzAQALBq9KAET6ieQ6acU0fOgroVogo6Z+Las3K/mdIHMmy1UR1DGKHr4KCil
         sR4A==
X-Forwarded-Encrypted: i=1; AJvYcCVQaY6cGAY3AFASQRwAUaW2gr8/tPP+pCAcmEQKZM4usXObxlN840byxrNzvF7iR1drJgcwHu0J@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4XmdbTzAZDAPNWzEPlvhOa171JCFa1mpwdsjJnl/TLYsm8X/a
	gWLyNqn/GXyXA0iIdZVwyovSNVkfXtJKg7APidS6OJTamFYmdGHhU6bLWgMZsRXZNKQ=
X-Gm-Gg: ASbGncsjG1+BVJnX3/JZ+7/3niVVUJCkGYv0UvSj/QPXerTamvMXbeolcpqIU4B69Te
	zF7CTi9dlLSX4QguaS9S11FteE51UkUm8KqkhbVeqr9u4iLFNXHgjCM/MvFPHl/bCDFjlSmZGwh
	p+ZU3/4qhtAOmuTJus7DwDun5gE+uuxtLKroWwZ7NVODJV3le3l+ELdkDR5uOuZZZrRyZ2xGb1M
	O3LS6ewGgwWvm/llYfMr4hRCWogLauEBerdNJnW18ToGZj2b6JClf9898KUFOkWbTagkpwY3RKX
	x0DmQJ6YR4FbIaBxkIq/MS6Spai59v/wS+0WWnheXlQw/IfoALzpcVzIjiymlKorgWN83DgPnMI
	=
X-Google-Smtp-Source: AGHT+IF/N5/hf0d2fwMzP5+TqXu5cETtfyyVL5Bb81xxCyv/IqnZpdoVIHLqUV7ToAyh1pCxOCMXgA==
X-Received: by 2002:a05:600c:a087:b0:453:a88:d509 with SMTP id 5b1f17b1804b1-4538ee42c26mr214486335e9.10.1751357781237;
        Tue, 01 Jul 2025 01:16:21 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406ab6sm159969645e9.30.2025.07.01.01.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 01:16:20 -0700 (PDT)
Date: Tue, 1 Jul 2025 10:16:18 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc: Tejun Heo <tj@kernel.org>, Waiman Long <llong@redhat.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, muchun.song@linux.dev
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
Message-ID: <p5dssax5ac6ndongdhp4bvnmy3gz4pswdxoogbmy66bhk5zqzg@bfurmve7htwi>
References: <aC90-jGtD_tJiP5K@slm.duckdns.org>
 <CACSyD1P+wuSP2jhMsLHBAXDxGoBkWzK54S5BRzh63yby4g0OHw@mail.gmail.com>
 <aDCnnd46qjAvoxZq@slm.duckdns.org>
 <CACSyD1OWe-PkUjmcTtbYCbLi3TrxNQd==-zjo4S9X5Ry3Gwbzg@mail.gmail.com>
 <x7wdhodqgp2qcwnwutuuedhe6iuzj2dqzhazallamsyzdxsf7k@n2tcicd4ai3u>
 <CACSyD1My_UJxhDHNjvRmTyNKHcxjhQr0_SH=wXrOFd+dYa0h4A@mail.gmail.com>
 <pkzbpeu7w6jc6tzijldiqutv4maft2nyfjsbmobpjfr5kkn27j@e6bflvg7mewi>
 <CACSyD1MhCaAzycSUSQfirLaLp22mcabVr3jfaRbJqFRkX2VoFw@mail.gmail.com>
 <jtjtb7sn7kxl7rw7tfdo2sn73rlre4w3iuvbk5hrolyimq7ixx@mo4k6r663tx2>
 <CACSyD1PhM=U1bxqYeZXHojSRWWPB3Y7j30jLLykjRzLuQQzn2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghzklq2pmnvye4ii"
Content-Disposition: inline
In-Reply-To: <CACSyD1PhM=U1bxqYeZXHojSRWWPB3Y7j30jLLykjRzLuQQzn2Q@mail.gmail.com>


--ghzklq2pmnvye4ii
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [External] Re: [PATCH] cpuset: introduce non-blocking
 cpuset.mems setting option
MIME-Version: 1.0

On Tue, Jun 24, 2025 at 04:11:01PM +0800, Zhongkun He <hezhongkun.hzk@bytedance.com> wrote:
> The cond_resched() is already there, please have a look in
> migrate_pages_batch().

Thanks, this is enlightening.

> The issue(contention ) lies in the fact that, during page migration, the PTE
> is replaced with a migration_entry(). If a task attempts to access such a page,
> it will be blocked in migration_entry_wait() until the migration completes.
> When a large number of hot pages are involved, this can cause significant
> service disruption due to prolonged blocking.

migration_entry_wait() waits only for a single page (folio?) to be
migrated. How can the number of pages affect the disruption? Or do you
mean that these individual waits add up and the service is generally
slowed down by that? If the migration was spread out over longer time,
the cummulative slowdown would be the same.

Thanks,
Michal

--ghzklq2pmnvye4ii
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaGOZUAAKCRB+PQLnlNv4
CLqrAP93FjIrFWvD3uXoAQYwirGWulGtE68jLEXl0TFfgWAk0gD/cmzZCwsHU4Qh
EqqezNCBFMoHnUOeL0+hkfekbIN5wQg=
=dVmN
-----END PGP SIGNATURE-----

--ghzklq2pmnvye4ii--

