Return-Path: <cgroups+bounces-7227-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC303A6E217
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 19:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE70C167F84
	for <lists+cgroups@lfdr.de>; Mon, 24 Mar 2025 18:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368EC2641E6;
	Mon, 24 Mar 2025 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LR7H1z8y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CD58460
	for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 18:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742839841; cv=none; b=jwDuAI/o2npwJRDIPZQDnTsbggMuk0I9xu97OovX+0RPIw8MrYREo/yy4X3FIZWxgZh6g9wtVexOUqV5sfAPkj7n+j5Btn+y+IMG/dOWg75E7QRtpeXif7ZdgnPVlVcmNSRaTiJExxzS30i1x3bGHcQfzLtEMe5DtRHx1c1bwFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742839841; c=relaxed/simple;
	bh=W5EH4HgBMT2RDd5dV38icviVxonI3A9D3prl5SuNkFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtMP/yswowKuDtVcYGTr6AASGZV0AmoGF2UZcGg2qUbf3qemC1zTUmuiM+GIneyHqnK+b+qW+0KMs3M03QQCSV0XzgNeAeV2Ho0QCLmUx3bTj62ud+Pi6WeBAcn1VWhqex5UKRrFGmULQ8SdQubPu7+flQUwedBHf/kE3/lRaSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LR7H1z8y; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-391342fc0b5so3695985f8f.3
        for <cgroups@vger.kernel.org>; Mon, 24 Mar 2025 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742839837; x=1743444637; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W5EH4HgBMT2RDd5dV38icviVxonI3A9D3prl5SuNkFs=;
        b=LR7H1z8y7SSIOrY31Y45gAqS+8KjgYiOGxmO9pGOiWvztPAQOhz74JDzFPDyWcHEtT
         LbR+2xC/4knDjjANZBb3iVcSV684+o02yWNSsiD6y5pmVVpu8TfG5E0YbEKIyWpLu0ne
         KV5NzXms6x43zIgcLB4y/Uy4ahwMc6LY/MhYFO7h+lspkMEthslAJe4C8S9ng+Tii576
         EE591B+JHlezm5oxIJ9/MBqLeq2mmrMuPkC9nBHl1laXQdUWe4LxKlyzaM+dfORMq/Xj
         KNhgm9++s9HqLu4XI2/Y1z3TabIyRflh5CRn9RWRWr/nMyAL0FzIi9lBfzTmXeq/PIBm
         yAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742839837; x=1743444637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5EH4HgBMT2RDd5dV38icviVxonI3A9D3prl5SuNkFs=;
        b=kEwIEcA6CK2w6jQFTDk6betbm62Oc2pGxcKqDyPAM7WAVQD4o+ifH5tggZJFGPme7U
         5V/cQpMivjwln/q6d1lbXdFhEG4ohs50f7jx7ISKbFY8hQrXhG0eok2IFrxresTT/UO1
         rs1vSN6miCMTeMGyHJ1BzJbOd5urHeYPGpKyVQWGB2b17vBd0Enbfet5cl20CqMkm6yU
         0GLL09gEZGiw2KZqPn6n4hRHQ1LhzdY13LEmXgN11uwktnR56CULTygKbgX5TMNpESe1
         GUTTjOxtBHuWzopr1XWqt2VcAwFXVn4TuCZqIZghzimxlnudwsY6aPe1+Mqwwkfqm9hx
         gp9A==
X-Forwarded-Encrypted: i=1; AJvYcCX075n27SGiVRRdWaPn0yEtEYhqHo2zeYQlKrJPqdCXn0i7Ezh6SvyJUtl5OyIsfu+IQmz0rZv+@vger.kernel.org
X-Gm-Message-State: AOJu0YwftL8pIh3pqd8RiR+nj4lGYViFE0bMM3tIg3bbGPF38RX/a/Uy
	lHICto8hZcLV4+WI8RK7s1qkts4x6cJ/CAuE6Vpx/6YR62q1GN8yWk31OeroEc0=
X-Gm-Gg: ASbGncsczNLt5Z0m1Hopk/6z9YpKcACzKzgFQS3ia2PbvaReplCy6SuvPL+6UbIG+A5
	ReY1TWHN29dIWZYj3dZ2m+1Jg4InUxRjFcn9oZELyeGyNEXwq2l78rXiFZ+FqD+PmBAaEd++eEA
	abBIQsil3VmuofNY0L+q2H+uRsEespgnHYgzIkjxriENI4uTF2ujI6DlsQjS1WJMfJjwlXS/SN7
	htI9Xk1wxjcyT1sDTZuDtAeGVjqXpYVD1IvgkJQ7MBy4kCDfLLNoBL18kTrrUhyhj5YFMwPo19N
	y/JF4K2oEfKZl21hO0kNhpyIRViXrIp/VaaMOiEmEvp2i8OmZzIXbHzjEg==
X-Google-Smtp-Source: AGHT+IG/xbG9SBbPWm/sxYQIS9iqyav4ZhR+Hp91ZTDsfvDr2jprMyVZFlSeudZyAmY/H8KBjJbSew==
X-Received: by 2002:a5d:6d0a:0:b0:391:306f:57de with SMTP id ffacd0b85a97d-3997f9405c4mr12816495f8f.45.1742839837294;
        Mon, 24 Mar 2025 11:10:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceae03sm133023595e9.8.2025.03.24.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 11:10:36 -0700 (PDT)
Date: Mon, 24 Mar 2025 19:10:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Frederic Weisbecker <fweisbecker@suse.com>
Subject: Re: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
Message-ID: <5k6sdc6fha7cnxkl4k54vpxjukld7tevslkcl4i3xwvedea2s4@lugqjbp47jqz>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sk7gjmsjwmnhfo2b"
Content-Disposition: inline
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>


--sk7gjmsjwmnhfo2b
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 00/10] Add kernel cmdline option for rt_group_sched
MIME-Version: 1.0

Hello.

On Mon, Mar 10, 2025 at 06:04:32PM +0100, Michal Koutn=FD <mkoutny@suse.com=
> wrote:
=2E..
> Changes from v1 (https://lore.kernel.org/all/20250210151239.50055-1-mkout=
ny@suse.com/)
> - add runtime deprecation warning

Peter, has this addition made the boot-time configurability less
dreadful (until legacy users can migrate to something better)?

Thanks,
Michal

--sk7gjmsjwmnhfo2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ+GgGQAKCRAt3Wney77B
Sfh1AQD4AOnacq2Seg8evRvg3BkvnZUEsr9AdUOlOB48pFxO5AEA7CYrX9ngBYGI
LhR7BHSBWP7qXxI+yP/3L+wRu6sw5Ac=
=0U7+
-----END PGP SIGNATURE-----

--sk7gjmsjwmnhfo2b--

