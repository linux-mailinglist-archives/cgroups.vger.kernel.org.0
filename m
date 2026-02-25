Return-Path: <cgroups+bounces-14382-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC1cE3VUn2nXaAQAu9opvQ
	(envelope-from <cgroups+bounces-14382-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 20:58:45 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7026519CFDF
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 20:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D4DAF3013C74
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0FB3EDADB;
	Wed, 25 Feb 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFL6eTNt"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61DB3ED11F
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 19:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772049518; cv=pass; b=JyegpqFPkbs+4UHk7TKghiulTP9fnI4A/PZRsTHt2Z25fMho3BifLhxc6yjyb19eRJ5gf+Ogf4fGKqCO6ON43em9KrqI6YeKVU3Yn2IuUn9YjTThyzI3HWo/VuNyZ8JdT8r1R0QEjbGgyWxnHHLrS1CvruphjocVoqy2naxeOvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772049518; c=relaxed/simple;
	bh=GyourlDdj2Tljzk6rLtG6gEQuh1sMzPbchn9jIwrybE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrqfecdojQo3pF/UkE5CvE+34rttJJGwkhVxnF4lyUigTeBF3MZimjWoy4Lp+naTGkM1HmcOweaiti/GcS0yqstLQhHX1GQRhEKFWlRxKdTnSU/r+ur8EFt2U1Ma1SoNpIXMykZEO3iWW3QMguP5U3hQ4AKTD0JnwVhSe1Ugg9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bFL6eTNt; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c01595082so204113a12.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 11:58:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772049515; cv=none;
        d=google.com; s=arc-20240605;
        b=LSEqoyFMukDPrQTWtv5CuuJgzr479d2RHMlGmtlRZ3YxUkdsjMVXXbIn4/FLv9BT41
         GJ/DvHmc78fr7Y74d9vjOoVNO9API1aUwqc7k7S7yZzU4Tzb0XWs1lMm+8mV3Go5ZxKl
         +8XAQBbjRtjcliP8nSAcILTFH1ePpnoJLYxj0pF4qEhl4BxNa28pqtarjpikU5+l6bJ9
         rBGPot3n1DelVm2sSDN/pMlN2XnGSZa52rUlVHQSBtTLfnuMFj3KcJfwCYSym7/DYHU8
         ksL+qjY99KNiumcCjpQuo25D9xXn6sBvsd9HOFmGA3sYw6XQ7ERFZpdsYuq53qmb3eHB
         db7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GyourlDdj2Tljzk6rLtG6gEQuh1sMzPbchn9jIwrybE=;
        fh=UTrliKBwtJ6qLUeEGybzPan0+3vN34jwImGVsvoH9k8=;
        b=kDzFKtyECv1CYtAH5jgGAeBtukVM7d2WF+DB29rCjYh3Wi/PYWoiIAW/QWqxOhGyOq
         fLBDHTBbKmgB+wkoHKUYuETLJPiWbeKKDv0y3YKp9U4gMaO4VM43GU5pPSo1k7AKMoKO
         1sAIDxkvhFoZkFSpqwCwhPb7Tn9zW0mKmYCkjVTkBsQfoZy8jmxNNkkmG+Jw23iJUV/h
         /pNgey/iaE8G8Wgl7DxzO1/zmhNjNMXYFAP+pLRObBLbqpJhyKnXE0xOL+QI+nVcKGcJ
         xvtxhMWBMJa3dUVvQ5g+VRjUYSD7t1U+DqxK0tMguVZa3wOvNh9G9KwfyhzF35P/Bixo
         fcbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772049515; x=1772654315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GyourlDdj2Tljzk6rLtG6gEQuh1sMzPbchn9jIwrybE=;
        b=bFL6eTNt0ihHjvtATq7bScLjK6enVQGNaoem2xoRRLK8Ew4nYSJazV6bWkZMPxAQsV
         UhC3mWJsZfeF/A+u0J9AQnY+7p187R8GY2Prhip4N7tba3TFsVbslyQrXbEYPDw7rH9+
         aY4p0XwM6xLTAjaRC/dSltMfEDlKjahJVjAjjwlLCKECBOxIaoyoTQ9rcm+FG/PZwqxb
         1tckypd6k6VNo9ETKnLnu77yPdZuWOB1Q715+HhSbCH4w2Sjmm1Safjpuv3SEtiqghCw
         kgI44223VIKCrX99yUGJ8RFA+XPX6GEwl3t304vtzkgePB7xkzHfF2oBjUYo+7cuugim
         gDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772049515; x=1772654315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GyourlDdj2Tljzk6rLtG6gEQuh1sMzPbchn9jIwrybE=;
        b=ikXvXqKrqsulSRWZL6MAWj8JNVYcmnw8tL8x01Vf/TJ2ln/iJs4h3o5UXIvYKP9DoE
         rbNb77rJLQmG6yImMuMU9eb2eFtSU6bVXBLhZPsm1iSMiK2sS0ZRPfeLbMv6xiW3vRKP
         FSpmJju5zdwl616XjJpfRgwRjtTueEtKKLtKufHydEtCDFlMaiPLXzV6LEh5iqfuwKXq
         NOjfeo31ch1HQjppW2/a6Rjw6aoNHuLe0SaOZmorVG1VXKBVMxLrhBBmt2G1WL859kKR
         7U3VdmiUVx6vFTyFKlhhvDXISbQhu2WsF1628ttPUCXomN0i7zcy7ay2NMd/5fhDNODx
         LOUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeYU8EoWUgVzC8vAau/RQBTaA4+Ql2C8xiwEpru2YC9xkLjxleZuldlO+e5sFcxI2UnQxVgRgj@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqsy+yycxasQ/GwFTALC/PQn4whPsxXgeFOAQ+v09LooGbV425
	k7QY7xgMZfnDfUupUQM38cMsE9zIatj8F0NHDIcu49YJepbOVAy28iMNQtflc7accC/A00hT/mM
	I+0qttTcwV+AJWPgbzJeAL/GLwiNyGDzQ3z/elblp
X-Gm-Gg: ATEYQzwXFAmpdgaSau7sED15dIVSQkt52+xC4jgBSc1RlZTxnIJeWIaifawnfaFtuZQ
	oPvhMB5bwsoHY1pzZliKeTdJWYd8NGyOWB2jba2fY7MrbEmu725cD7ZAawnFMtFD7XrzWZ4c3AY
	rIlCDyQRh0p6xxSNyB6jalUclQHidNjir+vq3h/F7LtGQyX10fSau8Kc+eJKXSprLdLfeaa+/fJ
	p4I9jcEIoqk56is2bGYSSquj+u/fSRE9I/U+NtTZMUB51rstg7027lWh2po/A2vzdA79tB35UWV
	vXdJfiYPQKhsIWWTVZgmihT/0fhM60byun3Y8BHJ938KBdHMWVpm1M064HPnIOfdROhQCw==
X-Received: by 2002:a17:906:209c:b0:b87:1590:d528 with SMTP id
 a640c23a62f3a-b9081b6d72cmr674923766b.40.1772049514649; Wed, 25 Feb 2026
 11:58:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770854662.git.ackerleytng@google.com> <67a62716952c806c2a512e98bcac1f5224ada324.1770854662.git.ackerleytng@google.com>
In-Reply-To: <67a62716952c806c2a512e98bcac1f5224ada324.1770854662.git.ackerleytng@google.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 25 Feb 2026 11:57:58 -0800
X-Gm-Features: AaiRm52wU6KkL251Z2G8sJq02VAiPYyNCCNpcDmsxM2CKPU8i6iZmZDmernmq44
Message-ID: <CADrL8HVSqhdUAQ=OPicZSPnaCXQMTweZ0rqvXp_86p_xnZ1Bbw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/7] mm: hugetlb: Move mpol interpretation out of dequeue_hugetlb_folio_vma()
To: Ackerley Tng <ackerleytng@google.com>
Cc: akpm@linux-foundation.org, dan.j.williams@intel.com, david@kernel.org, 
	fvdl@google.com, hannes@cmpxchg.org, jgg@nvidia.com, jiaqiyan@google.com, 
	kalyazin@amazon.com, mhocko@kernel.org, michael.roth@amd.com, 
	muchun.song@linux.dev, osalvador@suse.de, pasha.tatashin@soleen.com, 
	pbonzini@redhat.com, peterx@redhat.com, pratyush@kernel.org, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roman.gushchin@linux.dev, 
	seanjc@google.com, shakeel.butt@linux.dev, shivankg@amd.com, 
	vannapurve@google.com, yan.y.zhao@intel.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14382-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jthoughton@google.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 7026519CFDF
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 4:37=E2=80=AFPM Ackerley Tng <ackerleytng@google.co=
m> wrote:
>
> Move memory policy interpretation out of dequeue_hugetlb_folio_vma() and
> into alloc_hugetlb_folio() to separate reading and interpretation of memo=
ry
> policy from actual allocation.
>
> Also rename dequeue_hugetlb_folio_vma() to
> dequeue_hugetlb_folio_with_mpol() to remove association with vma and to
> align with alloc_buddy_hugetlb_folio_with_mpol().
>
> This will later allow memory policy to be interpreted outside of the
> process of allocating a hugetlb folio entirely. This opens doors for othe=
r
> callers of the HugeTLB folio allocation function, such as guest_memfd,
> where memory may not always be mapped and hence may not have an associate=
d
> vma.
>
> No functional change intended.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: James Houghton <jthoughton@google.com>

