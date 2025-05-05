Return-Path: <cgroups+bounces-8007-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E426AA938E
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 14:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBC5189A7C0
	for <lists+cgroups@lfdr.de>; Mon,  5 May 2025 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1D1FF60E;
	Mon,  5 May 2025 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="QTiuQjfu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947041C63
	for <cgroups@vger.kernel.org>; Mon,  5 May 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746449364; cv=none; b=paa0v74G1blyalHXwqeYNAblwhRV0rIkwVpBpOoFYnsBcxMLsJO5nnJt26KGu3ysxtv0hJpEEF94kHWqLwJSbWXYXSjfZx+z+vOaw3u7B+sNlCJvsQGrn5V3xCtOZ2Y2GhDtCrBKVaUp6N95Wz4MN3zyWb1xGKiTIk+LBfah1BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746449364; c=relaxed/simple;
	bh=h8U5EjZrfZ43MNluZJU7SJSY3c+wYPMqp+iyFq6DTYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWmz0cFmknyc0VTerrEgcc5WvtqYyy4IIBZY210Ttl9Pvvmko+0rdzL5fb8eB43wrYVDOG4Euzy8v6hHEsJve6umUKEn5gzD6Az+QAbWM7Qon5+oY77eugHEXPoxr3n7OcUUdSX+sT+Bpaxd+Pa0jHh/kinaydm9CiN2uD2mLaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=QTiuQjfu; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2963dc379so625603766b.2
        for <cgroups@vger.kernel.org>; Mon, 05 May 2025 05:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1746449360; x=1747054160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8U5EjZrfZ43MNluZJU7SJSY3c+wYPMqp+iyFq6DTYQ=;
        b=QTiuQjfu97S6HjAEBiEp1Wc7QSASiNm7eedJoAN1a7BPZz+WbUqZrdR128wE3dy3Zx
         UKxVVEKcxdBIlf/6kiptIyq+Uobhwh3IRlyu1iSzSi0SUcaZNguFTGG77s8CC6qyT1rz
         8to4nPv6jOXK+1iqaWlL5x8CoEwHPcnlqgC/0JYXPJmEopuMMT+4djo2MFZT2KC6uR40
         ZwkaevAP2/QWPaNNcLCLn1zlKtJYGnUZRmDNOtKXUZM4e+WtEAvFgVgjTiA6chiKXI5d
         UGjRKEmQKNahRjErjmNxShLoCSMlaAqLGDAmoiVotY0BAS2+wJUTXgHd1exYxrBdxl2G
         uMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746449360; x=1747054160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8U5EjZrfZ43MNluZJU7SJSY3c+wYPMqp+iyFq6DTYQ=;
        b=ndkAqAUH+yFc6fzIKoo0u9hxyW23RI6b/aPBiDmR/z0VAfZYReZV7LPN+ChtxFVjNx
         nFZ0BtROwcV4Lyo60NtdyAzulE5b0GoA7Pm19HFf80LubanIXoImXzYPG1YZl2DNXuwy
         EMMdRG2gWlZI/EOLd43X7ZB/rWn9kJOwCIO6LSXruc2ImGAyLyxLruGtzKmBV+B8sogu
         kT93QXna+6UtLA5/gvxotEMFYbt+XcBOywslWHxAtymGD4DcjYzeJbPYJGkcRtefjcUO
         QlouA1OlO6M09OAbXFrBQft2lQlY6TbJ+n8KKy19/nlliaMEAXtD4IoOoKncP1cqLtnV
         ObWw==
X-Forwarded-Encrypted: i=1; AJvYcCVQcN8SF/BAkTEgWCQnrkpV/nj5wKlN1lFHmmxHzkp4undV/NjqFjAEgntKbMECv5sH5yTjV6sm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2eJVWWOlELUu89WdhSxPaMS2bGXmcJQf6sIaTlY+fxYuy6Lsf
	ziTskASqlqQXe4wEn/y6MGz37hJ4HoFa260DylNLK6BItiBJunzkdeeHQY/4nzxb+E0OwHa2WH3
	LDjlCnLCK4tCv3lE9H6lXvgzc7e1iQQH3NwuQPQ==
X-Gm-Gg: ASbGncu+3D7hsYeqI2OT3rcY6Slt/jb3y86vBDWzmzJFOh6dn2EnVNkrWtuwrcGfy/X
	CGLew4JDN03CBoFEMlOcMinhTPt+Pc4VLs/j5xNhndFNylhnQr71LlpCxJDLMmonvrPqNINoEw0
	SRagEBi21r2EHEvhEpirSrZfcgAlFi6GtEjEIvC9D21a+Ezpldb64=
X-Google-Smtp-Source: AGHT+IEQEtAmpp+U0f2k8eePl7xd6XBIyArt8z5V5X5PFgIVOlVsppqEAvzfY9M3D0lDOqaLheEog4k1PKphraOtuYs=
X-Received: by 2002:a17:907:72d1:b0:ac7:1600:ea81 with SMTP id
 a640c23a62f3a-ad1a4b1d6c9mr659162766b.49.1746449360263; Mon, 05 May 2025
 05:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250502121930.4008251-1-max.kellermann@ionos.com>
 <bbublxzpnqrzjq5rmmbp772w2darjoahlewqky7caanaknglbx@6wuy5nidsnu3>
 <CAKPOu+_8cbUk=8d41GQGOvUrmG9OuaNVuSQrksDcUQMyFc4tiA@mail.gmail.com> <aBUQ7EzmeWYCyLwB@slm.duckdns.org>
In-Reply-To: <aBUQ7EzmeWYCyLwB@slm.duckdns.org>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 5 May 2025 14:49:09 +0200
X-Gm-Features: ATxdqUEYQB6USgmiCAV7OU2CKrYQgnrzCesPwZ7-NaiO3m6zeMlp7cMoAYide5M
Message-ID: <CAKPOu+_Dk7rLgc+5YbMd4xpcjz74XKnR1jkgaTxu81EvE-q1-g@mail.gmail.com>
Subject: Re: [PATCH] kernel/cgroup/pids: add "pids.forks" counter
To: Tejun Heo <tj@kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 8:37=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> +1 on pids.stat, and use rstat and avoid the atomic ops?

rstat right now is specific to the "cpu" controller. There is "struct
cgroup_rstat_cpu". And there is "struct cgroup_base_stat", but that is
also specific to the "cpu" controller.
Do you want me to create a whole new subsystem like the "cpu" rstat
(i.e. copy the syncing code), or do you want to add the new counter to
cgroup_rstat_cpu? (And maybe drop the "_cpu" suffix from the struct
name?)

(I have doubts that all the complexity is really worth it for a
counter that gets updated only on fork/clone. cpu_rstat is designed
for updating counters on every context switch.)

