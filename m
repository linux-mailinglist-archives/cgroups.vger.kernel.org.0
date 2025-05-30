Return-Path: <cgroups+bounces-8394-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED33BAC8B89
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64051650BB
	for <lists+cgroups@lfdr.de>; Fri, 30 May 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719E0221287;
	Fri, 30 May 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NtEsHjOm"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC7221CA0A
	for <cgroups@vger.kernel.org>; Fri, 30 May 2025 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599092; cv=none; b=MzzgyCi9sGDH7WHbf4gFjTNXMmaENQEeb0sUbuoSbQX+ZiJuGa/P5i3R2ohC6Llsx8oq+0+7N74ZyuJV5lBdHdZlCilFSWg15KyoN7HEnXHf2jzqmwe0Hzq/OEq8O3sTXRAGt2/WU0ZmUVb7Oqho/wiIZxh3g4QlwA72MOjvgQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599092; c=relaxed/simple;
	bh=06rysxkXnUrExFnGgrvtJc+zY6h+gcD7eGfOJ+tWEu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2sL8eXOjtrfpBKTQDqboI5S7y/Rs2bAvohjvRGiWFaKTi0g27vNsZqh7SO4KBkQ8yRmuDlzBwi5rh88PpP4HfnHwh0ApWIlgcKfOV30TEO5uVZsYCP7Mq7j/ShLIYXO0r++LfhNrH3t0KE1M1WdH27mmCSvA6HMWbOG1DX6AME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NtEsHjOm; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f89c6e61so233029f8f.3
        for <cgroups@vger.kernel.org>; Fri, 30 May 2025 02:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748599088; x=1749203888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DEvii1pOVk9lN8GqyI1B0fzW7CXipnBmMJVaTrcONTw=;
        b=NtEsHjOmhPuJrA1efMfonPZ8axV/AvkuH6XO1KPMaZVcic5aia9guRQqaMIlayxz+2
         F09oVHTPw1g4dkozZDTFEmXtdxKOZraMwG8pfPm3lqpzaXBUst4RAuFPXy5kaIZekADv
         nmUEF2+0gbK1Y09lUPAGT4sznOVIiG9ujWt/eO8Vi+mnQb6HuInhtEpiC1YJtYt94Yp4
         k3b9yPh6+8ewdIpxS+unjxIW4s5obrFOwC/zoJMNgloAwZ9Giouf84E2LkMX441i/NhP
         rcDnUX469d4LqvNpngwBNqEIT68CWQVJC0MYysl538HQjv6lbzTQLYYo5hyy74I5DxxC
         AyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599088; x=1749203888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEvii1pOVk9lN8GqyI1B0fzW7CXipnBmMJVaTrcONTw=;
        b=UxUtNxn6ALbkFVSg3a+ICZz7MuvxmWwDHwGYF6lwEIkmXhYoBK5EvvFuVc0GSiXMbF
         hk2pTqJatWQSK6B+QcOL/DppSo4DAFUyOHUKVpI6N9g5kFDvF9cg1KsD+Y+4OWcX9N99
         6ZzGTWbUcbLpltyTFvVuVVqz52YseLyI/qMsrmEsHQCAJcCDDwFyMLptIDSeVp8UHzbv
         w6XFY7lG8IpVN7t0JBnYXAfPRD5KrjhtK+uS1fko9rsSJr2XFQWB+ZojDLljTWQ9NIeg
         kSTw8lNl/KpvViCkHYF4i8Y6wdRKc1QmLt8Jk2ne9uq8xiJj7oilo3EGvZguWhKMtgP2
         ma4A==
X-Forwarded-Encrypted: i=1; AJvYcCWNhy/BAWgvf+YZ+bqtsWSTddlRRO3QbxlEpfQmgKfpJ6+Lw8ZBbcjAxgpYfvK5Af5J5g4Mry1b@vger.kernel.org
X-Gm-Message-State: AOJu0YwZGdgokeVUXxx91nGsMwr8E7DqjrIcnGV8rmZOqEaCwGWLUjnX
	BkZqE9XTKDmRyY++TRd6tRfxL14hPk3GWDqHfR7lZH7RCsAMnNMRPNEwMMs5xruLJ5o=
X-Gm-Gg: ASbGncvYRgrbbH29i/cILi9POAh/lqZ9WVoLHj5uCdxvofAyHT4iLDiPwKsdln+FnHl
	/Q5r3POCp9Rnjz9CDI/eK4lFO2C0Ex/xffmeyen5LHHFtwjkbel8YDqC9LVjvN0Srq7R74JvD/z
	OeEO62wyTaJY+ioKZvMBskktKOJ/1naxA/Xvhrstb4QUgcvdSKBXB8/WWpMWWBv9ypzOQ5fOxc8
	P03lBTDyKx+BvFc718yvw8SzNxKEhArsfFn+zjpwEfQFAmlb/j5kCUbTIBG42n4vm9ba/veUDsP
	00CnmX+tlII1UQWJeSzpfhShQffaypMXu+fe5QHLZmq2eUvID6XpJg==
X-Google-Smtp-Source: AGHT+IHxkayBOoksQdAIBCZb83R6LdCpek0pSUeOdEVaY1qIzGNrRd8I6KP16PXYgxeoEwy+Qfa00w==
X-Received: by 2002:a05:6000:25c2:b0:3a4:f786:4fa1 with SMTP id ffacd0b85a97d-3a4f7a3bd69mr2056066f8f.2.1748599088138;
        Fri, 30 May 2025 02:58:08 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009757fsm4400704f8f.78.2025.05.30.02.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 02:58:07 -0700 (PDT)
Date: Fri, 30 May 2025 11:58:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, llong@redhat.com, klarasmodin@gmail.com, 
	shakeel.butt@linux.dev, yosryahmed@google.com, hannes@cmpxchg.org, 
	akpm@linux-foundation.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
Message-ID: <eqodyyacsde3gv7mbi2q4iik6jeg5rdrix26ztj3ihqqr7gqk4@eefifftc7cld>
References: <20250528235130.200966-1-inwardvessel@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="q4wzbz5gvgo6qhhf"
Content-Disposition: inline
In-Reply-To: <20250528235130.200966-1-inwardvessel@gmail.com>


--q4wzbz5gvgo6qhhf
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH linus/master] cgroup: adjust criteria for rstat subsystem
 cpu lock access
MIME-Version: 1.0

On Wed, May 28, 2025 at 04:51:30PM -0700, JP Kobryn <inwardvessel@gmail.com> wrote:
> -	if (ss) {
> +	if (ss && sizeof(*ss->rstat_ss_cpu_lock)) {
>  		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
>  		if (!ss->rstat_ss_cpu_lock)
>  			return -ENOMEM;
<snip>
> +		 *                                                       When the
> +		 * lock type is zero in size, the corresponding lock functions are
> +		 * no-ops so passing them NULL is acceptable.

In the ideal world this consumer code (cgroup) shouldn't care about this
at all, no?

I.e. this
  		ss->rstat_ss_cpu_lock = alloc_percpu(raw_spinlock_t);
should work transparently on !CONFIG_SMP (return NULL or some special
value) and the locking functions would be specialized for this value
properly !CONFIG_SMP (no-ops as you write).

Or is my proposition not so ideal?

Thanks,
Michal

--q4wzbz5gvgo6qhhf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaDmBKwAKCRAt3Wney77B
Se4oAP0TgOK74gdlOsml80NrVPVWYnZ54wPfOuvReAYZfSrx0QEAgjTeoeUpau8l
1kQ2XBbURSGvSXAga2jJLBg5Hw2ZQAw=
=0XKk
-----END PGP SIGNATURE-----

--q4wzbz5gvgo6qhhf--

