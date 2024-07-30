Return-Path: <cgroups+bounces-3996-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6B9415A2
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 17:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6061F25229
	for <lists+cgroups@lfdr.de>; Tue, 30 Jul 2024 15:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5A91A255E;
	Tue, 30 Jul 2024 15:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UVBJt0pk"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394FE2A1BB
	for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354387; cv=none; b=jG6sejDNAdWRvj/vf1ii7LprGEmTbQm0nLEv1/TAuKsjv7YRjEozdZtB6weIYMxP7dtuuSkVPHuB5FoVQ4zpwaGzEsK2BTou5i7J6UKj1Q3y6zukvParDmrHFiLm6rjo4pPNo+Pq+nqeY64s2jR5zuZqvVxSwT47w3D6u19g6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354387; c=relaxed/simple;
	bh=yFVGl3IncTdtYdA43geU7rnxB9K1xpXsgvTVqUqWeq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzTO2ycu/75gZ4UcsA/jmSUtLRUXZ982qg0PFIGTHLMAzMAUwMFFZNJrsou17BMgc/wUliQ1QrYGazCBwx7GRQ1txE99lh09hf/Y3UIjMAnOO6+loMEIcTpyfP1C2WB+jcIfSpWKeijo+TI8fTWKaKR2XqVGCuUu/N8+DWJ7Z7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UVBJt0pk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7a83a968ddso667696566b.0
        for <cgroups@vger.kernel.org>; Tue, 30 Jul 2024 08:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1722354383; x=1722959183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yRC8EpL8O0R6ThyQIF5jdND8pmO+k3m9i0jeg+m0dq0=;
        b=UVBJt0pkshaeV455lPh1bvwNp7A6yMY2tNh3383eGlCnw0qE9AgsTUY/MTk3bKwjKG
         6JlYv2VQYrHMXcMI+Nvb3557VBYKcZMJx7qGSZsr2103duDDRZofEA7A6MqtNCIolIzM
         /pbZxTmacmCWzr8zud33w2SIwJvZ37C93RAFh9CSeHfAdIAgBCw+nyA795sIePLdwFlk
         N53SokCT+VRH6qI6MDt6WGRm9EpR0Pv4FTg5/Z4AeBuVFMSaccXGUuLuoIhHAgzAXal/
         IbXjEWv1JwxCiV/kxW8ZNuCJ+q0sU1giaLEISTlfzI6Fa4/yiDQcv/SlX/vwL31l6isP
         /lKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354383; x=1722959183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRC8EpL8O0R6ThyQIF5jdND8pmO+k3m9i0jeg+m0dq0=;
        b=kfkjG/bxf67INdX/nZsIe1eTAmVcdQ6PBTSQr+vLwKY+Ffip0FSZWuMvAK9z1q9js/
         vFPgrByYnOZkBsv2mzLrOUtaBvb4H2+1JqG/pigMJb2H0HjSgUCRrHM9ywjffb1IQAjw
         pcr/X4F5f/FUHeirGgxLCHUsMrb1z+tGKn7urRmVsXmonco3omgUPkTTYHXiOPvwM+vs
         /1z5oZ7LrqkMEqPRzv3eU3bShVJS4kUbbWX4kmGRHAXmP7EPvfxP9pj3baTt96/es6lC
         GrnLCTIoxG1Sy0jMlI5X4pF9Rbn4GU5vZCLsDyEc9MMZeZyHnoc0MZKyKQbohDoZ65hm
         EURQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWdLMgWRt9uZofyYCL3WNAYWQHHDdPpDnlIoW4wHK9wV466TH8J5MvuMEamt9WOr2ow/8LDYYaCj2K9KX1ZvqhhVT9J2QEGA==
X-Gm-Message-State: AOJu0YwXLttzEVeDm1UdbyxGToljewf92//F+H4HfnqlanQjWP0vWgjJ
	lseJo3g5ypm/c9JVLjTg3opBxvy9X3idPXHetSTWHn047MAodLWJGZId9rM2Jk8=
X-Google-Smtp-Source: AGHT+IEfShq2dlD0DfRiwM7bhyC9H1giL0hs81+b3W/KP3MMitXJ+IPNIAfmGBJOB3tFyCz+0fCaCg==
X-Received: by 2002:a17:907:8692:b0:a6f:e47d:a965 with SMTP id a640c23a62f3a-a7d40064576mr768295166b.41.1722354383418;
        Tue, 30 Jul 2024 08:46:23 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab23125sm659769766b.1.2024.07.30.08.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 08:46:22 -0700 (PDT)
Date: Tue, 30 Jul 2024 17:46:21 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: David Finkel <davidf@vimeo.com>
Cc: Muchun Song <muchun.song@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	core-services@vimeo.com, Jonathan Corbet <corbet@lwn.net>, 
	Michal Hocko <mhocko@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mm, memcg: cg2 memory{.swap,}.peak write tests
Message-ID: <arkcd6cjf42zq62maqsbjzvimxwozrkukusgxhd54v6eyd6ylq@aurn3mek6hr2>
References: <20240729143743.34236-1-davidf@vimeo.com>
 <20240729143743.34236-3-davidf@vimeo.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5y6eempyzjoj5ljb"
Content-Disposition: inline
In-Reply-To: <20240729143743.34236-3-davidf@vimeo.com>


--5y6eempyzjoj5ljb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

On Mon, Jul 29, 2024 at 10:37:43AM GMT, David Finkel <davidf@vimeo.com> wrote:
> Extend two existing tests to cover extracting memory usage through the
> newly mutable memory.peak and memory.swap.peak handlers.

BTW do the tests pass for you?

I gave it a try (v6.11-rc1+your patches)

$ grep "not ok 2" -B30 test.strace

...
315   15:19:13.990351 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:13.994457 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:13.998562 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:13.998652 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:14.002759 read(6, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 4096
315   15:19:14.006864 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.current", O_RDONLY) = 7
315   15:19:14.006989 read(7, "270336\n", 127) = 7
315   15:19:14.011114 close(7)          = 0
315   15:19:14.015262 close(6)          = 0
315   15:19:14.015448 exit_group(-1)    = ?
315   15:19:14.019753 +++ exited with 255 +++
313   15:19:14.019820 <... wait4 resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 255}], 0, NULL) = 315
313   15:19:14.019878 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=315, si_uid=0, si_status=255, si_utime=1 /* 0.01 s */, -
313   15:19:14.019926 close(3)          = 0
313   15:19:14.020001 close(5)          = 0
313   15:19:14.020072 close(4)          = 0
313   15:19:14.024173 rmdir("/sys/fs/cgroup/memcg_test") = 0
313   15:19:14.028517 write(1, "not ok 2 test_memcg_current_peak"..., 33) = 33

grep "^315 .*read.*4096" -c test.strace
12800

Hopefully, unrelated to your changes. I ran this within initrd (rapido
image) so it may be an issue how rootfs pagecache is undercharged (due
to sharing?), instead of 50M, there's only ~256k.

To verify, I also tried with memory.peak patch reverted, failing
differently:

...
238   15:30:29.034623 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.current", O_RDONLY) = 3
238   15:30:29.034766 read(3, "52801536\n", 127) = 9
238   15:30:29.038895 close(3)          = 0
238   15:30:29.043048 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.stat", O_RDONLY) = 3
238   15:30:29.043230 read(3, "anon 52436992\nfile 0\nkernel 1105"..., 4095) = 870
238   15:30:29.047379 close(3)          = 0
238   15:30:29.051491 munmap(0x7f2473600000, 52432896) = 0
238   15:30:29.058516 exit_group(0)     = ?
238   15:30:29.062992 +++ exited with 0 +++
237   15:30:29.067054 <... wait4 resumed>[{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0, NULL) = 238
237   15:30:29.067136 --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=238, si_uid=0, si_status=0, si_utime=1 /* 0.01 s */, si-
237   15:30:29.067210 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDONLY) = 3
237   15:30:29.071349 read(3, "52805632\n", 127) = 9
237   15:30:29.075470 close(3)          = 0
237   15:30:29.075562 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDWR|O_APPEND|O_CLOEXEC) = 3
237   15:30:29.079712 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDWR|O_APPEND|O_CLOEXEC) = 4
237   15:30:29.083848 openat(AT_FDCWD, "/sys/fs/cgroup/memcg_test/memory.peak", O_RDWR|O_APPEND|O_CLOEXEC) = 5
237   15:30:29.083970 write(3, "reset\n\0", 7) = -1 EINVAL (Invalid argument)
237   15:30:29.088095 close(3)          = 0
237   15:30:29.092209 close(4)          = 0
237   15:30:29.092295 close(5)          = 0
237   15:30:29.096398 close(-1)         = -1 EBADF (Bad file descriptor)
237   15:30:29.100497 rmdir("/sys/fs/cgroup/memcg_test") = 0
237   15:30:29.100760 write(1, "not ok 2 test_memcg_current_peak"..., 33) = 33

This failure makes sense but it reminded me --
could you please modify the test so that it checks write permission
of memory.peak and skips the reset testing on old(er) kernels? That'd be
in accordance with other cgroup selftest that maintain partial backwards
compatibility when possible.

Thanks,
Michal

--5y6eempyzjoj5ljb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZqkKygAKCRAt3Wney77B
SRUAAP4/N9esJbrEK3Dc8W7fMPFhJO2vSYHkWLaM8DmxVvSNLwD/e6VjqMIAdSUh
SFcFj4YkO6Uy6D5wFhGyjPQbmHi3lwg=
=GgTK
-----END PGP SIGNATURE-----

--5y6eempyzjoj5ljb--

