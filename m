Return-Path: <cgroups+bounces-7985-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A68EAA6E5E
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 11:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07261730D4
	for <lists+cgroups@lfdr.de>; Fri,  2 May 2025 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40004231840;
	Fri,  2 May 2025 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNh6wRok"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD02422688C
	for <cgroups@vger.kernel.org>; Fri,  2 May 2025 09:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746178990; cv=none; b=DGg9FxSjKoR/GNxKB4Uhojgu+nZRPTe6lHEmZoRzjZ13/BsJM0yJvwi2U1I69g8oLOqEY50bHjQb8tx//FvKrv7s/GoVQxX2bHmEEp6Dr8lAF60Tz9s/5o3ZNRgXZq1etXTD9opFKeNKnhG15yzFy/3FVybNYy/8bQo1yh6oJAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746178990; c=relaxed/simple;
	bh=EOXqPqomDY5NAmOBb/66KqDnP+k/LNaa1HXt0xFQ2zI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqDA7n9VQ6iMsI9ozph8KLOhCAoOtLyc7AKTgP2L+E9Cp9MaqpfJJPW4zIsrT466OIjjiKF/eXmYt0YHMRtz520JQybbhqAseond5ZJ7NjoWHzOSwgARN/DolZ5lJOkFdKqSxGguSSpSRVathMJ4zJUhuLC6/GYbjR5vorut5Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNh6wRok; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f6c3f7b0b0so3621089a12.0
        for <cgroups@vger.kernel.org>; Fri, 02 May 2025 02:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1746178985; x=1746783785; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EOXqPqomDY5NAmOBb/66KqDnP+k/LNaa1HXt0xFQ2zI=;
        b=FNh6wRokeH/ZCOx305hS36t3HW2+EwT+Do9ehclCuwwr+qGSa/GJbRNbSo96uup9MA
         Li4bnKCQCRy9YIIS2e/lT7F5Gvo5WsQHmOrEwdXsx9PRplZHbrZLmQ/f6wAO5vEp1cNJ
         8S/hqtBxJal+gGXb3n+j43uZKENhG3bdnMCLV3jZdVEg5EnA4XlhkRCiiru3cHhfYQ66
         dbEnFUUUUZWDuLg87insbdA0X9C/eUAknM1kuac6oUV4uvlBKmQg148blv2+ACJknt8F
         KEU97tU08Nj4/daV5QVi/yMqlQcLcSAT24sTu92N9W+UkAQx8LDPOrGPie/NK8PFC2LI
         Je6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746178985; x=1746783785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOXqPqomDY5NAmOBb/66KqDnP+k/LNaa1HXt0xFQ2zI=;
        b=e4HImVNjhWwBn/x16W63Gm+Y4hZ4T08WO6wbF3QE7WM3cHrrJR5d0o3F2YF1zBa16O
         peicGCXRAcUzHBe/C6433/8NPZ0di3UuRbWIlQNnKIvsQJZl335pwxk9+72K/fWb7ZHI
         afcDGI2637t+5boTG2l+gv7nFmdcExMgNpyXv9J1MXOgDmo4wkxDfYltYYZ+fBVh7d4m
         Q1JV/VNOOaEX73pfq4dV4D7LSSyuUKszgSxPOH6Vee2f0Qb26oWIulIS/TbqwffASr8F
         /nbYeFstcIKAxUgr3pLWJ4nYweGLJfW52xExB3aARr2jy+xINpHMaJuOl8vEX6zM+Sgf
         2dAw==
X-Forwarded-Encrypted: i=1; AJvYcCU30U19sL6TZcOZpVzhKPbEwSzu2L973FQJkMHm4q2QZ7AC8+rprSFg61t9qyz+LJOvBsT6hj6V@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WII7OOt0G4GiT2wOxrTfTcYMiQUzZNWihUYevA66syWsln3G
	RM+8peEh6jnao9CzoZKXQZk9F1oxQPEMv+l+TvOTSaepTRczUFpKnWSydwLWSfA=
X-Gm-Gg: ASbGnctCYRo0z0qUXbH2+Q5e8tXqJPExrIrR/FC8SjaWHYeZcUep6LXXexn1eVU4rHH
	iiA9S6XYP1IhQsOUi24JDB0ova+b9Ss8oL1rcr3EOtYw77oKF2NQoK54f5UA2QEgL5iTcw3OawB
	gM7Kgs+2ssFP2I0L+diepXbQeThQY37HbIFVjExBE5ajrXf1xwt+/g9ipQp6GYVKCkoOX3nlXF8
	BBuhZJX2OqEVoH1ZewYBUO+N6UADHn9BpZ+Z/hNevowa6RcjTHrjPyfEIleENamlpqHFYnr94QU
	rHQBxVha4JVQrfGjOoJVhFm3P5RO+zM/H0ZizTd9/pM=
X-Google-Smtp-Source: AGHT+IFgoRhv9PuW/EWdVGOS2zvRloJtSnlLvctJGmfk/l9H9pNgE/zk8qe2KUDmO+lth2FLCAP8OA==
X-Received: by 2002:a05:6402:d08:b0:5ee:497:89fc with SMTP id 4fb4d7f45d1cf-5fa7891aae1mr1661907a12.33.1746178985017;
        Fri, 02 May 2025 02:43:05 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fa7781bf5fsm942719a12.36.2025.05.02.02.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 02:43:04 -0700 (PDT)
Date: Fri, 2 May 2025 11:43:02 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Tejun Heo <tj@kernel.org>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v8 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
Message-ID: <vki6asa3arxitfgio3goox6hiyzmytxskoje6e2z55j3xrskly@4jq4btqz5nwd>
References: <20250502010443.106022-1-longman@redhat.com>
 <20250502010443.106022-2-longman@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="55lyjcmxpait3n53"
Content-Disposition: inline
In-Reply-To: <20250502010443.106022-2-longman@redhat.com>


--55lyjcmxpait3n53
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v8 1/2] selftests: memcg: Allow low event with no
 memory.low and memory_recursiveprot on
MIME-Version: 1.0

On Thu, May 01, 2025 at 09:04:42PM -0400, Waiman Long <longman@redhat.com> =
wrote:
> Modify the test_memcontrol.c to ignore low event in the 3rd child cgroup
> with memory_recursiveprot on.
>=20
> The 4th child cgroup has no memory usage and so has an effective
> low of 0. It has no low event count because the mem_cgroup_below_low()
> check in shrink_node_memcgs() is skipped as mem_cgroup_below_min()
> returns true. If we ever change mem_cgroup_below_min() in such a way
> that it no longer skips the no usage case, we will have to add code to
> explicitly skip it.
>=20
> With this patch applied, the test_memcg_low sub-test finishes
> successfully without failure in most cases. Though both test_memcg_low
> and test_memcg_min sub-tests may still fail occasionally if the
> memory.current values fall outside of the expected ranges.
>=20
> Suggested-by: Michal Koutn=FD <mkoutny@suse.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

Acked-by: Michal Koutn=FD <mkoutny@suse.com>

(Thank you. Not sure if this can be both with Suggested-by, so either of
them alone is fine by me.)


--55lyjcmxpait3n53
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCaBSTpAAKCRAt3Wney77B
SclRAP4sVLHHxS41vhM1p+JYRz4x68kM1ToNUs7M3I1xd7X9XQEA9Lg0Obh9pUcU
RmcQibMDF9amuynS7EPQ0DQjGlQ+lQ0=
=iotP
-----END PGP SIGNATURE-----

--55lyjcmxpait3n53--

