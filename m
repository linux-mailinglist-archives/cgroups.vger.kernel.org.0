Return-Path: <cgroups+bounces-6975-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A079A5C2FD
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 14:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3B53B11A2
	for <lists+cgroups@lfdr.de>; Tue, 11 Mar 2025 13:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA59F1CCEE0;
	Tue, 11 Mar 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZQGJfqTI"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB231487E9
	for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 13:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700981; cv=none; b=YbyEcRUmLYh2JQdTP3r4W4ZnjUu95uW3QKHw01oWUINiogt7ow37MAILrbBkVk1zhByIdrFPfDdtVott3q44uJFdn6p2QjrsvG8uol+3+CHcq/RMUEBvPaR3umOg2Ya9WIND8mRD1xA/CKDeIFJFae4d4JK1SfaU2ZlNryHJTQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700981; c=relaxed/simple;
	bh=vScjEivhYdfVHvI2tSn+P+7Eluf9xWviNNomHGftrVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHrY1Gb3bfGlSgonrRjRrq5cZi+nClkfn6TeakEyJOtCqkaTk0lhurAYgkgF6NecJBeOBIJcMNgxIXDCxR1ZrY9JfFyZslCrmVRY7ir/1kaFk+fRzysF/HMlJavyODAPnK4rKsDGuPtT64OAqJak2HRhnmJMbVYvJ3buguUtcY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZQGJfqTI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43690d4605dso34028585e9.0
        for <cgroups@vger.kernel.org>; Tue, 11 Mar 2025 06:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741700978; x=1742305778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RlZHNg9yhg3SzjB7LxxqzdvnbsuoathUQwWLXPBZZPM=;
        b=ZQGJfqTIlQv73JriFLg6VOH0IZyW/MxbKv3M9rILYXKgS+RiOsEFUive7SPtn+4TMW
         yvHn+T3+GucyIYShhmhbJAZNguAb+CNAQZL69rx+daL/RwMBDEwfE9W4OJQyD7e+rW09
         J9V8Abp+O1/cuGnh6cBWi7LKaqvORySMQUe74xXryabeYUt3dLPwR8KBt/2Tk07tjej6
         ScoN+sLgCTkhBMWw0K4NXFoHGMG0NjL5BnoHJHJNQwGpI2qC1c7C09QUWwAnB8CoEqFM
         9bSWdLwGTQbT8ZKB0PMLbP8dIMI4uLgxzNJzybkqoCdbPg1apAXB8q3toxRIutRjpJ3E
         s53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741700978; x=1742305778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlZHNg9yhg3SzjB7LxxqzdvnbsuoathUQwWLXPBZZPM=;
        b=tNSQnrAUMpkBsyFCwBdU6qiiZEtOWFHCU33z3wlio8RacjpL1iyHfX6I+VLMAftort
         Qx55LKn5KoKqUe5huyS6E0vYUQpGVSUH5FJguCkiuPwhgXVv1nPYXJq+1nF5WJLYWa/B
         iaeLKamk5869eyX+39QAPLA4SpMx4x1KUOTbThm0WPa2Qo6+y6k4TfmmWjmat/TsJM1X
         O8DB4GD+9slnmrNjSKpZglsbpHV6xG8Pcq0sKXmummK5U/MeTBOmbX/s3FayBmgtPhVs
         VeYQ6+Eqxbdsewpk73/at/xCR+aVHDw1GPg1eF5XPg56Hqa4p0qeFKWLgplNla6ZlJUN
         rXNw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Hjx0R+0qkCt9E0jGAZ19PBA7mLEDS2E3jSilWgFkG9Un7gWrTFGB6xvCE1roZARRFyrFQuOu@vger.kernel.org
X-Gm-Message-State: AOJu0YxYQJG8Ufp0xVP8s2iVDQFojqLzS4WXmxNoijhE7I5ldDFY4bue
	h+myfIpV4neqVH1a2bku6ZQp8nrGJRzDe1MQMrJrDsea7bD/kGco5jhcmESgzNo=
X-Gm-Gg: ASbGnctFlIwgJD8UstMqM5zkEQ+y1qSTqHMX5tF6FpDqutF6VWkInoCyEvaIwWyNzDm
	D3XXbKfxAnEX63p2pYeAXLw9LrJ1BHmGoRIfkyGh9tSDmqheHtU/5Y+jo0O252qXZJIwzTAf9Fo
	89QUhO9zQE4bNP7hxntaW95I5l5wzRz80ZV5dIjaprvunz5x3IuZZy/1oN42Dv52w50QDO7J/3g
	xOT8do89qc0Dxk92SFv+nTLUu24n7MzmMdZ59KlDfrG9EUJUZPJOIvGCGTzBTD0sHsVqR/am79h
	IT4ewUDUrCU+9JtRISoYteW9T+lbyiZdHR15I8Tb+M8pTwE=
X-Google-Smtp-Source: AGHT+IGO2jeFa+PgVDcTzL5RDaY9VZ8d2PFJuvU64B5OwM/B9gzkS6wcRA5JmSi8aOeqBP2HQtovEg==
X-Received: by 2002:a05:600c:4708:b0:43d:10c:2f60 with SMTP id 5b1f17b1804b1-43d010c303cmr45005665e9.24.1741700977845;
        Tue, 11 Mar 2025 06:49:37 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ce8a493d0sm120392695e9.1.2025.03.11.06.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 06:49:37 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:49:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: JP Kobryn <inwardvessel@gmail.com>
Cc: tj@kernel.org, shakeel.butt@linux.dev, yosryahmed@google.com, 
	mhocko@kernel.org, hannes@cmpxchg.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/4 v2] cgroup: separate rstat trees
Message-ID: <frrvzvhexeb4wmdhjtjmdnbleg43nmcvf2vh3ayzt6hptazt5n@gzjka7dkhby7>
References: <20250227215543.49928-1-inwardvessel@gmail.com>
 <ee4zdir4nikgzh2zdyfqic7b5lapsuimoeal7p26xsanitzwqo@rrjfhevoywpz>
 <c1899b5a-94a8-4198-be0a-5d2b69afd488@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3fto5w6pevkh6njs"
Content-Disposition: inline
In-Reply-To: <c1899b5a-94a8-4198-be0a-5d2b69afd488@gmail.com>


--3fto5w6pevkh6njs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 0/4 v2] cgroup: separate rstat trees
MIME-Version: 1.0

On Wed, Mar 05, 2025 at 05:07:04PM -0800, JP Kobryn <inwardvessel@gmail.com=
> wrote:
> When the entry point for flushing is reading the file memory.stat,
> memory_stat_show() is called which leads to __mem_cgroup_flush_stats(). In
> this function, there is an early return when (!force && !needs_flush) is
> true. This opportunity to "skip" a flush is not reached when another
> subsystem has initiated the flush and entry point for flushing memory is
> css->css_rstat_flush().

That sounds spot on, I'd say that explains the savings observed.
Could you add a note the next version along the lines like this:

	memcg flushing uses heuristics to optimize flushing but this is
	bypassed when memcg is flushed as consequence of sharing the
	update tree with another controller.

IOW, other controllers did flushing work instead of memcg but it was
inefficient (effective though).


> Are you suggesting a workload with fewer threads?

No, no, I only roughly wondered where the work disappeared (but I've
understood it from the flushing heuristics above).

> > What's the change between control vs experiment? Runnning in root cg vs
> > nested? Or running without *.stat readers vs with them against the
> > kernel build?
> > (This clarification would likely answer my question above.)
> >=20
>=20

(reordered by me, hopefully we're on the same page)

before split:
> workload control with no readers:
> real    6m54.818s
> user    117m3.122s
> sys     5m4.996s
>
> workload control with constant readers {memory,io,cpu,cgroup}.stat:
> real    6m59.468s
> user    118m26.981s
> sys     5m20.163s

after split:
> workload experiment with no readers:
> real    6m54.862s
> user    117m12.812s
> sys     5m0.943s
>=20
> workload experiment with constant readers {memory,io,cpu,cgroup}.stat:
> real    6m57.031s
> user    118m13.833s
> sys     5m3.454s

I reckon this is positive effect* of the utilized heuristics (no
unnecessary flushes, therefore no unnecessary tree updates on writer
side neither).

*) Not statistical but it doesn't look worse.

> These tests were done in a child (nested) cgroup. Were you also asking fo=
r a
> root vs nested experiment or were you just needing clarification on the t=
est
> details?

No, I don't think the root vs nested would be that much interesting in
this case.

Thanks,
Michal

--3fto5w6pevkh6njs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTd6mfF2PbEZnpdoAkt3Wney77BSQUCZ9A/bQAKCRAt3Wney77B
SW+DAP9MRwSkgfcF2q0SYv7iwTiItXhXwvL26zMPc1X6xOaKZAEAyJDXgE4sh8ew
GyN5lrwplSNM5SbTJESB9q+JxBLVBQ8=
=E+84
-----END PGP SIGNATURE-----

--3fto5w6pevkh6njs--

