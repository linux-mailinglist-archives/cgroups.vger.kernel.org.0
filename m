Return-Path: <cgroups+bounces-9214-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1E4B28007
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 14:34:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271285A854C
	for <lists+cgroups@lfdr.de>; Fri, 15 Aug 2025 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DAA288C23;
	Fri, 15 Aug 2025 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BktOj1Et"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7852D052
	for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755261257; cv=none; b=Fk5t3GrSf2PL/163rdAz2EB+2z6AMgsbeXdDibPY75Es+qsr6vNG7nisf3sl2o7Lz+n4GMLCjzCuGqDMela0gv1frIRGd8WjWow5EGAmK2P5dgjuqQKUXbcrxiQVwJsiJSSlbUFIAmmKVT167Mfvnar6OCuWaw960tuNdwY6xo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755261257; c=relaxed/simple;
	bh=2NPBJgIbug0Bh+0ak17HZ4aogx7N/v5utSxx0PGuCKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC1k6d63zmUdNlcAmJ68U2JqerdhBY9A/UtQwnFXXDG7iPxm3bvUBtHo0ITposcg1czgwFQyddxM2PjrT+0YMPoayPUdtb1hkHqtxuVlZfRIQNEtdi6Cw7Yzl1OE3UomC82AdEX5cxZW5qIvWxc/BlKlSO/CPEwPjnTnlehM+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BktOj1Et; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e4147690so1127718f8f.2
        for <cgroups@vger.kernel.org>; Fri, 15 Aug 2025 05:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755261254; x=1755866054; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NPBJgIbug0Bh+0ak17HZ4aogx7N/v5utSxx0PGuCKs=;
        b=BktOj1Etftc/hzF6N+qUmNOfwsQvBMN0/m8i1mG1pq5xDUQQVMs02tCISPs/rCWs6S
         7UJTC7SWBT/slTELayNHsnPQ/w0dMRvislbFQ3t00+sTzf/jYLJ3Ofn1ySsfGbu7dY8b
         1GwF9GPmdW+yqZch7hoG7FaNuiN8qj0rXGqLknOCuHdVCspxzIwjZ/JAAPIf9HWxtOOI
         ZjhthdD49OtsPSLhpV90AE31+E5TjvKGR21C35KgElXWUCVKbIlcuJQaJAdzHhyG1TgW
         lAMCxYOyGs9Ei4N7lm+DdzDoJ2roBHhnOAa1hlkF33SVmaBS0rmNlqiJov+efQ64RFWX
         nWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755261254; x=1755866054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NPBJgIbug0Bh+0ak17HZ4aogx7N/v5utSxx0PGuCKs=;
        b=VoPJ8z4eUNF89kUM8OwpvOzSYJHSWQtDAesGtwdnN6aHaq0fobBArG2V0lUobyRNsU
         W7fhC2C8eJblge2W6sCBvV1y4B0pe7Xl1fwjU4HHY+B6f+QGn0kXG4XdchaZfudEIS7b
         KcyaIwOVzAR3ufRxAPc72y6LZmnzMSFMx9tpyOQm0JTl1b02t4QsGCZpkLMYIeEJuDku
         UQxZKJY7aeT/CsVxXrdhXImbnNbVlQ1IcJuHmXmHut45VoB+SjIF6U/ss7UUcaez+o5f
         ofFJB3qHk1gm4O08HR1IUup7QZuNyFOe9c69faigvpjkpyNJ2nbZNJ0595quTw/rQQZA
         Tpjw==
X-Forwarded-Encrypted: i=1; AJvYcCUDeeVFxZ+wcNlRHCnktwkbmjQrQxDGNbkwiS0RL+t5k0tOHsWeSwtEIRBLpXG2V9hPDsmd7FXQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx59q6J5Q8cftHn7hQYRF50qISJXIuffjZgJ5OwP6Z6hW3NDJeK
	mHex2fXUMnpoTsmdmssn5YWXSD17nWuKwQ264KzbfP94JGoo/RNFlTSc4OoxhBxJ05o=
X-Gm-Gg: ASbGncvML36NCUc8wQueWJoVEeo+g2+7YjYJ8IMuAW6297H7HCzT4gHkMoxNlGU5Nt3
	0paBlmkvCb6bVr1b/wCDaB8dBrlRE8wQKwW52rcwfJKZj8V7g5ZD4T6vaykaP7X6O7Z2KmMsEqB
	TTAkvQL1/EVuTmpdwLzopbqOmDuuSNcz1mjlQuzS8M/ZgLeRrxPTmmL/IdzdK5t47QLvR6m0/mV
	TNNBujOipXmOkeEoxcuAQChjF825Hgz2L/7tXATH4RsQr4X3Gejn/u/rt9eIY3V0veM8zPMff93
	vzgxcLfcPCI3ZV+IK9GR9SOn4+XiB7gX8FBQCb6IaYBMJgHJ2OgB0ATK4P5UdtV3Vhd2B5pFl8v
	HTskIyVUlp0qGO/6dN9bC5yf49K1R2ipASxrai6wfbJAN+1Yj1S88
X-Google-Smtp-Source: AGHT+IHOvaE7tZeHngdDROJ3VBbwyIHwQY//OcWQOpF4xFO/7x0xp2UXIVTyys/GbEi0VR5R6Dqu6Q==
X-Received: by 2002:a05:6000:1888:b0:3b7:99a8:bf6e with SMTP id ffacd0b85a97d-3bb694ae038mr1734547f8f.51.1755261253797;
        Fri, 15 Aug 2025 05:34:13 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5f4539sm1195356a12.14.2025.08.15.05.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 05:34:12 -0700 (PDT)
Date: Fri, 15 Aug 2025 14:34:03 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: lirongqing <lirongqing@baidu.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: Remove redundant rcu_read_lock() in
 spin_lock_irq() section
Message-ID: <f64n5c6dkdjuaudk5p66mvpjyjulrjytmndqufmdu3uhft46sy@bem2gx34zhkz>
References: <20250815091430.8694-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lxgzoylpx6c2h6sk"
Content-Disposition: inline
In-Reply-To: <20250815091430.8694-1-lirongqing@baidu.com>


--lxgzoylpx6c2h6sk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup: Remove redundant rcu_read_lock() in
 spin_lock_irq() section
MIME-Version: 1.0

Hello RongQing.

On Fri, Aug 15, 2025 at 05:14:30PM +0800, lirongqing <lirongqing@baidu.com>=
 wrote:
> From: Li RongQing <lirongqing@baidu.com>
>=20
> Since spin_lock_irq() already disables preemption and task_css_set()
> is protected by css_set_lock, the rcu_read_lock() calls are unnecessary
> within the critical section. Remove them to simplify the code.
>=20
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

So there is some inconsistency betwen cgroup_migrate() and
cgroup_attach_task() (see also 674b745e22b3c ("cgroup: remove
rcu_read_lock()/rcu_read_unlock() in critical section of
spin_lock_irq()")) -- that'd warrant unification. Have you spotted other
instances of this?

The RCU lock is there not only because of task_css_set() but also for
while_each_thread(). I'd slightly prefer honoring the advice from Paul
[1] and keep a redundant rcu_read_lock() -- for more robustness to
reworks, I'm not convinced this simplification has othe visible
benefits.

Thanks,
Michal

[1] https://lore.kernel.org/all/20220107213612.GQ4202@paulmck-ThinkPad-P17-=
Gen-1/

--lxgzoylpx6c2h6sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaJ8pHgAKCRB+PQLnlNv4
CLeEAQDhACSSxzfculiGEZg5K7CYSS8BDwlcU8+9yAxEJIfsLwEAmbKaApjfh0Ki
8I+wSutS8pxwWUO8EeeZ9jbous+NrQw=
=uUm4
-----END PGP SIGNATURE-----

--lxgzoylpx6c2h6sk--

