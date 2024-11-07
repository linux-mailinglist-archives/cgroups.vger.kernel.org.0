Return-Path: <cgroups+bounces-5475-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F069C100D
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 21:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB0B2337B
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2024 20:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E117218319;
	Thu,  7 Nov 2024 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BJzsrIto"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86562178E3
	for <cgroups@vger.kernel.org>; Thu,  7 Nov 2024 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012498; cv=none; b=hTl8V0Fd+2TgKtsT96hImkmAcd6bEyOlZAnoYXYYwmj/tXeRciErOJ8/w6RqLzrjRybXumVB3zVcjT2fU4kjk+uyCLZftusHzYYRk9RO/Tu/npJ1dAr/SzD2Z1sDiAEOzMgDp/7Af4S7IBB5XIXminmDlHaedB6udsXeK6HVVqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012498; c=relaxed/simple;
	bh=L2JnZy+FpJjZq2hoDPKEQjvM+JNDSZhn7qTteDh5tWc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sJ13yhO0oLm5x/lpTqTTN8mu6+tlxTfvIGn/Ydz73bFDvaMhK4kQhyZx2ebEor86RutemHJUYiShKATeTdYsXRehCL647aKsKZCxW0r6wKjcnG8V6yILnpxLpMFsnauwhCFXgac8S+iR4hUCcBeo3IlQ3rDf9tG2vr0XiOM/A2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BJzsrIto; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e330f65bcd9so2184184276.1
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2024 12:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731012496; x=1731617296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tgFF/vf8m24mqzX/IMYi9zJNPzKWJ3qSX08ShIAreE=;
        b=BJzsrIto3s5ikwCRMHSF8x3wyY327ru3E/5+3rP7pPPY3Qu69rNhp0bAvaIUr0/aBf
         pMZN490nMoRb6qq73qtxtTczc4XHYSzx0cIyMpJtGW25ekytIO7EmpT24V8ewbg9i0kU
         QpmBCNnsyspc0IuuPqOVPtFzZJTWlLnaGaAeLU2vQ2wF2R/Sg3wVkhb4A0+FezLnP6C+
         95OmlPULcl5O1CcwId2+KHThlxmrBVwNSwwA6wGFjxDUlJSwTC//WUfCk/cZjyWJP0j6
         JeENibGLeGcNcVvCpQw6WFrzF4yqTx1U0jfLqULw3fK4JgI9KAz8uquW3IufVw44aWdD
         QmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731012496; x=1731617296;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9tgFF/vf8m24mqzX/IMYi9zJNPzKWJ3qSX08ShIAreE=;
        b=RTtAmooaBhSnd5eE4BKxo6Lodnn4wd9RyVP9NCHjgPBSXmOUuXFrlCxd/9bay4AhVk
         KaxYlThqgRwrR/PRkgMaAYWAcyZ//pB4UOkqdPGIzePB5StSpBfiSWDhaRXXuCha4Bti
         xyVPWFn3WmTNq2BqnJjEYBxJKd0nFjCqSIuQVFnKwgy1yIRCES2LExK2e3n9T6gY0ouL
         T9RAKPTdcXVvIS7wdeoiqLNeNBdEUjRmnW5vk1Ks5HZOGUafcZFFCOxuvlxUTijpcYjQ
         eu7HFlA5qMriZJV/mSnrtn5043nCEwhD+Fw/2/g9UiB5F6WlRTbpIcCmvyX2gnvrgF2T
         mFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUHt2eZNn5pRLFasslKaYgsP/LpaKKWVx1VYHq4GGuyblKN0jAWHYNi2SCPKlhgKtt6Td8Q19AD@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/A0r/NLuniywjT6MlCgo4YEdKPBlm2WCT2D9YaEVFYY6sdxQ
	MMxO7Ca1P8sLHKNuPIWapZ1v3P2iY1oBS6ffFEwxgX61ckE5GXLPbup61JHopBW2ja9yuOjbN78
	uyQ==
X-Google-Smtp-Source: AGHT+IGS34K7Djy3aJITzLWueG1h/SQAZjPBoQvYGi8UH9Cq6cPlMxmMBI4tn55IpfbmvQ570TOXglQxxzg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:a25:c584:0:b0:e0b:f6aa:8088 with SMTP id
 3f1490d57ef6-e337fd8c39bmr619276.1.1731012495813; Thu, 07 Nov 2024 12:48:15
 -0800 (PST)
Date: Thu, 7 Nov 2024 12:48:14 -0800
In-Reply-To: <Zy0M9yv7xIiKB_Xi@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZyAnSAw34jwWicJl@slm.duckdns.org> <nlcen6mwyduof423wzfyf3gmvt77uqywzikby2gionpu4mz6za@635i633henks>
 <Zy0M9yv7xIiKB_Xi@slm.duckdns.org>
Message-ID: <Zy0njoaJGS9310eR@google.com>
Subject: Re: cgroup2 freezer and kvm_vm_worker_thread()
From: Sean Christopherson <seanjc@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Luca Boccassi <bluca@debian.org>, Roman Gushchin <roman.gushchin@linux.dev>, kvm@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 07, 2024, Tejun Heo wrote:
> Hello,
>=20
> On Thu, Nov 07, 2024 at 07:05:46PM +0100, Michal Koutn=C3=BD wrote:
> ...
> > I'd first ask why the kvm_vm_worker_thread needs to be in the KVM task'=
s
> > cgroup (and copy its priority at creation time but no later adjustments=
)?
> >=20
> > If it can remain inside root cgroup (like any other good kthread) its
> > job may be even chunked into periodic/deferred workqueue pieces with no
> > kthread per KVM at all.
>=20
> That'd be better but I suppose kvm wants them in the same cgroup for a
> reason.

Yes.  The one and only user of kvm_vm_create_worker_thread() does non-trivi=
al
work on behalf of the VM, and so we want all of the CPU time consumed by th=
at
work to be charged to the VM's container, e.g. so that a VM that is generat=
ing
a lot of work doesn't negatively impact other VMs on the same host (the amo=
unt
of work done is directly affected by how the guest is accessing its memory)=
.

