Return-Path: <cgroups+bounces-10393-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20DEB953C1
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 11:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A577216D8DB
	for <lists+cgroups@lfdr.de>; Tue, 23 Sep 2025 09:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A6931DDAB;
	Tue, 23 Sep 2025 09:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="db1EavNV"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CB731CA5A
	for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758619460; cv=none; b=d8piV5a2YhfB4WWEKGmCbvz/fT7K09dkfQ6gZjLRjsEcaUtRPWzojiSOIu2m+5OJAsBZJfP+0QzB8PdFVNVvWtFBntWvuYzX8L/B5xxWoaSh7HTh87ncroQnLZMi+MRW7HqVKagAulsOgGOopKLQkx9vRWU9JEKm6qXqR6BHdXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758619460; c=relaxed/simple;
	bh=FOcIMd+9keinaLilY8OO52s6NS04W3uD/lD7wkU3AbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XgJfR++Yo4iEHh+xmDeGUzpffa2NwX90SZwbvRcbdMQOx1kRblpYPG96EKX0YOH4QMhJIzeM7f4647SjA6ifV6YoyZ6744M4shFv/ytTC5KttEKC+JlAy9EK65botVZsdrrUiPYaWbiBkQrbtn6QmJWZgMYRu4qi2iLcvreGie8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=db1EavNV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758619457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=P9HnCqS07HYrfeyO6g+j3mA7edWnw9iOky+d/Gvkfv4=;
	b=db1EavNVy8vEa4ioDWvkHSxGuRXYHQIDSYZrf4Jq70bwNT3Grn0JCEnaByd8rR2HZDRvVY
	klicJ8Sr7ck7tIE1Fk9bR4LObu+UEat9aFZgZjSY+l+HJ+8rEKcZ8MEPv/M7sLGpyvwjdl
	GKZ6CiEZThA+tNX1rRA5kOCh1+qUtRI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-iX1LJiHaMBm2_0re-gla8w-1; Tue, 23 Sep 2025 05:24:15 -0400
X-MC-Unique: iX1LJiHaMBm2_0re-gla8w-1
X-Mimecast-MFC-AGG-ID: iX1LJiHaMBm2_0re-gla8w_1758619455
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee130237e1so2471490f8f.0
        for <cgroups@vger.kernel.org>; Tue, 23 Sep 2025 02:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758619454; x=1759224254;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9HnCqS07HYrfeyO6g+j3mA7edWnw9iOky+d/Gvkfv4=;
        b=CvVLjZfwR3CyPtyvX2NB9F9ZDhBVdl1vZWzyH5tvK+sTsHUwAwDOTelsOQTMbo3tJ9
         4VewC1cmMOoQzJ3jVRIIbg9a0tFmbxDRj2NcXs0+b1tqx+kfVv3ykuMdRu1znwFZVJRQ
         IiuVXwdvujWFUWRJiEQBRVlG4kFoBerkjjyTuV/A2pdl+q+q8nwKg+DoewQfnFC/bFZu
         M/o07ARLHpGUQsR5EiTL8yUFqJgeFxVwJbwqG0i0c4c5C8e3d0dNi+qKI/aHaIQH6OLk
         TlAN90JnyW0XHnVsQryE2yKtQjKsw30K23e4+G1l5MKGzg/h7CjAabTKpubA7PUVwS/H
         gx1A==
X-Forwarded-Encrypted: i=1; AJvYcCVBAI8L9n5+AWoDQtZMNdoIJkxlf+KS48ElHMO2IJ1O2xXNYyTpWzkWfvVXu4nv8obvZzJ5y3Px@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0KeR2Xk0U/1IXEaBDK2zz2YJfRdaeu68qTdXcSWFL9e64VUG
	xbfcZiJbs6/XhexW1QTd8DoQeIHMvXbQYFtDLVXerlXldTMk6A4FV9Ac8RVXq89HtEfvTPJK61D
	9iC1MJKBy4eO1YPY8wPLUohfh9YvGTS8v3AALRLgveIlh3eA5WFDqeF5f270=
X-Gm-Gg: ASbGnctR/Osp3TPmfiQ2V81KvKV0g6+U/D48JZVRsyMY3wPdjp8dNdk5n7GDhnUqWj7
	0CueYBvOqRRyVI7ncjmPls70RTmaxCxsAWaSm5vTa1v+zvjxq32fXp8lsIP8MZDdyZqnz1pWrPO
	2QKs4qeoUW9iXQbT2aEbo3gpk4SIrBK4XG6wamH+3JFxrZPelLbH2HU71FbkCPsalVLLVXHbFGT
	joSdwRaFH/8heK8kLMUlRVeStCKTdAgYK7ptWlhjycl2sDMtztNNVS7VgXRPiBqLStAX6m1tpaB
	NAzVqZaC/Gs/80aGJpw8JHxD4Qli6jC6WrmxyzgV1FzLub6xJkhG2CHoht1vVIgVAQ==
X-Received: by 2002:a05:6000:1a86:b0:3e8:f67:894a with SMTP id ffacd0b85a97d-405c3c3e141mr1482015f8f.5.1758619454570;
        Tue, 23 Sep 2025 02:24:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdTcj8KWToZTschkhFy5Dh/ShDuYl9/1nyr4f2qhpfEJdISSNjftr0GCdr3GWRpwrGOXqOpQ==
X-Received: by 2002:a05:6000:1a86:b0:3e8:f67:894a with SMTP id ffacd0b85a97d-405c3c3e141mr1481992f8f.5.1758619454075;
        Tue, 23 Sep 2025 02:24:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f64ad359sm271457385e9.22.2025.09.23.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:24:13 -0700 (PDT)
Message-ID: <fafbf5bcdb3d89c718bb5646df48ed79215e3465.camel@redhat.com>
Subject: Re: [PATCH 26/33] cgroup/cpuset: Fail if isolated and nohz_full
 don't leave any housekeeping
From: Gabriele Monaco <gmonaco@redhat.com>
To: Frederic Weisbecker <frederic@kernel.org>, Waiman Long <llong@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Johannes Weiner
 <hannes@cmpxchg.org>,  Marco Crivellari <marco.crivellari@suse.com>, Michal
 Hocko <mhocko@suse.com>, Michal =?ISO-8859-1?Q?Koutn=FD?=	
 <mkoutny@suse.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo	
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 cgroups@vger.kernel.org
Date: Tue, 23 Sep 2025 11:24:11 +0200
In-Reply-To: <aNJlk7wcAsPF_j-z@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
References: <20250829154814.47015-1-frederic@kernel.org>
	 <20250829154814.47015-27-frederic@kernel.org>
	 <6457dd87-95cb-4c4d-aaab-6c9b65414a75@redhat.com>
	 <aNJlk7wcAsPF_j-z@2a01cb069018a810e4ede1071806178f.ipv6.abo.wanadoo.fr>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0



On Tue, 2025-09-23 at 11:17 +0200, Frederic Weisbecker wrote:
> Le Tue, Sep 02, 2025 at 11:44:00AM -0400, Waiman Long a =C3=A9crit :
> >=20
> > On 8/29/25 11:48 AM, Frederic Weisbecker wrote:
> > > From: Gabriele Monaco <gmonaco@redhat.com>
> > >=20
> > > Currently the user can set up isolated cpus via cpuset and nohz_full =
in
> > > such a way that leaves no housekeeping CPU (i.e. no CPU that is neith=
er
> > > domain isolated nor nohz full). This can be a problem for other
> > > subsystems (e.g. the timer wheel imgration).
> > >=20
> > > Prevent this configuration by blocking any assignation that would cau=
se
> > > the union of domain isolated cpus and nohz_full to covers all CPUs.
> > >=20
> > > Acked-by: Frederic Weisbecker <frederic@kernel.org>
> > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > > ---
> > > =C2=A0 kernel/cgroup/cpuset.c | 57 ++++++++++++++++++++++++++++++++++=
++++++++
> > > =C2=A0 1 file changed, 57 insertions(+)
> > >=20
> > > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > > index df1dfacf5f9d..8260dd699fd8 100644
> > > --- a/kernel/cgroup/cpuset.c
> > > +++ b/kernel/cgroup/cpuset.c
> > > @@ -1275,6 +1275,19 @@ static void isolated_cpus_update(int old_prs, =
int
> > > new_prs, struct cpumask *xcpus
> > > =C2=A0=C2=A0		cpumask_andnot(isolated_cpus, isolated_cpus, xcpus);
> > > =C2=A0 }
> > > +/*
> > > + * isolated_cpus_should_update - Returns if the isolated_cpus mask n=
eeds
> > > update
> > > + * @prs: new or old partition_root_state
> > > + * @parent: parent cpuset
> > > + * Return: true if isolated_cpus needs modification, false otherwise
> > > + */
> > > +static bool isolated_cpus_should_update(int prs, struct cpuset *pare=
nt)
> > > +{
> > > +	if (!parent)
> > > +		parent =3D &top_cpuset;
> > > +	return prs !=3D parent->partition_root_state;
> > > +}
> > > +
> > > =C2=A0 /*
> > > =C2=A0=C2=A0 * partition_xcpus_add - Add new exclusive CPUs to partit=
ion
> > > =C2=A0=C2=A0 * @new_prs: new partition_root_state
> > > @@ -1339,6 +1352,36 @@ static bool partition_xcpus_del(int old_prs, s=
truct
> > > cpuset *parent,
> > > =C2=A0=C2=A0	return isolcpus_updated;
> > > =C2=A0 }
> > > +/*
> > > + * isolcpus_nohz_conflict - check for isolated & nohz_full conflicts
> > > + * @new_cpus: cpu mask for cpus that are going to be isolated
> > > + * Return: true if there is conflict, false otherwise
> > > + *
> > > + * If nohz_full is enabled and we have isolated CPUs, their combinat=
ion
> > > must
> > > + * still leave housekeeping CPUs.
> > > + */
> > > +static bool isolcpus_nohz_conflict(struct cpumask *new_cpus)
> > > +{
> > > +	cpumask_var_t full_hk_cpus;
> > > +	int res =3D false;
> > > +
> > > +	if (!housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
> > > +		return false;
> > > +
> > > +	if (!alloc_cpumask_var(&full_hk_cpus, GFP_KERNEL))
> > > +		return true;
> > > +
> > > +	cpumask_and(full_hk_cpus,
> > > housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
> > > +		=C2=A0=C2=A0=C2=A0 housekeeping_cpumask(HK_TYPE_DOMAIN));
> > > +	cpumask_andnot(full_hk_cpus, full_hk_cpus, isolated_cpus);
> > > +	cpumask_and(full_hk_cpus, full_hk_cpus, cpu_online_mask);
> > > +	if (!cpumask_weight_andnot(full_hk_cpus, new_cpus))
> > > +		res =3D true;
> > > +
> > > +	free_cpumask_var(full_hk_cpus);
> > > +	return res;
> > > +}
> > > +
> > > =C2=A0 static void update_housekeeping_cpumask(bool isolcpus_updated)
> > > =C2=A0 {
> > > =C2=A0=C2=A0	int ret;
> > > @@ -1453,6 +1496,9 @@ static int remote_partition_enable(struct cpuse=
t
> > > *cs, int new_prs,
> > > =C2=A0=C2=A0	if (!cpumask_intersects(tmp->new_cpus, cpu_active_mask) =
||
> > > =C2=A0=C2=A0	=C2=A0=C2=A0=C2=A0 cpumask_subset(top_cpuset.effective_c=
pus, tmp->new_cpus))
> > > =C2=A0=C2=A0		return PERR_INVCPUS;
> > > +	if (isolated_cpus_should_update(new_prs, NULL) &&
> > > +	=C2=A0=C2=A0=C2=A0 isolcpus_nohz_conflict(tmp->new_cpus))
> > > +		return PERR_HKEEPING;
> > > =C2=A0=C2=A0	spin_lock_irq(&callback_lock);
> > > =C2=A0=C2=A0	isolcpus_updated =3D partition_xcpus_add(new_prs, NULL, =
tmp-
> > > >new_cpus);
> > > @@ -1552,6 +1598,9 @@ static void remote_cpus_update(struct cpuset *c=
s,
> > > struct cpumask *xcpus,
> > > =C2=A0=C2=A0		else if (cpumask_intersects(tmp->addmask,
> > > subpartitions_cpus) ||
> > > =C2=A0=C2=A0			 cpumask_subset(top_cpuset.effective_cpus, tmp-
> > > >addmask))
> > > =C2=A0=C2=A0			cs->prs_err =3D PERR_NOCPUS;
> > > +		else if (isolated_cpus_should_update(prs, NULL) &&
> > > +			 isolcpus_nohz_conflict(tmp->addmask))
> > > +			cs->prs_err =3D PERR_HKEEPING;
> > > =C2=A0=C2=A0		if (cs->prs_err)
> > > =C2=A0=C2=A0			goto invalidate;
> > > =C2=A0=C2=A0	}
> > > @@ -1904,6 +1953,12 @@ static int update_parent_effective_cpumask(str=
uct
> > > cpuset *cs, int cmd,
> > > =C2=A0=C2=A0			return err;
> > > =C2=A0=C2=A0	}
> > > +	if (deleting && isolated_cpus_should_update(new_prs, parent) &&
> > > +	=C2=A0=C2=A0=C2=A0 isolcpus_nohz_conflict(tmp->delmask)) {
> > > +		cs->prs_err =3D PERR_HKEEPING;
> > > +		return PERR_HKEEPING;
> > > +	}
> > > +
> > > =C2=A0=C2=A0	/*
> > > =C2=A0=C2=A0	 * Change the parent's effective_cpus & effective_xcpus =
(top
> > > cpuset
> > > =C2=A0=C2=A0	 * only).
> > > @@ -2924,6 +2979,8 @@ static int update_prstate(struct cpuset *cs, in=
t
> > > new_prs)
> > > =C2=A0=C2=A0		 * Need to update isolated_cpus.
> > > =C2=A0=C2=A0		 */
> > > =C2=A0=C2=A0		isolcpus_updated =3D true;
> > > +		if (isolcpus_nohz_conflict(cs->effective_xcpus))
> > > +			err =3D PERR_HKEEPING;
> > > =C2=A0=C2=A0	} else {
> > > =C2=A0=C2=A0		/*
> > > =C2=A0=C2=A0		 * Switching back to member is always allowed even if i=
t
> >=20
> > In both remote_cpus_update() and update_parent_effective_cpumask(), som=
e new
> > CPUs can be added to the isolation list while other CPUs can be removed=
 from
> > it. So isolcpus_nohz_conflict() should include both set in its analysis=
 to
> > avoid false positive. Essentally, if the CPUs removed from the isolated=
_cpus
> > intersect with the nohz_full housekeeping mask, there is no conflict.
>=20
> I assume this was fixed in latest Gabriele posting?

Yes, this is basically what happens in these lines in [1]:

> +static bool isolated_cpus_can_update(struct cpumask *add_cpus,
> +				     struct cpumask *del_cpus)
> +{
> ...
> +	if (del_cpus && cpumask_weight_and(del_cpus,
> +			housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
> +		return true;

Thanks,
Gabriele

[1] - https://lore.kernel.org/lkml/20250917161958.178925-8-gmonaco@redhat.c=
om

>=20
> Thanks.
>=20
> >=20
> > Cheers,
> > Longman
> >=20


