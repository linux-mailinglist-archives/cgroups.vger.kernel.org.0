Return-Path: <cgroups+bounces-4913-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071A997D39A
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 11:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AEED1C23FC9
	for <lists+cgroups@lfdr.de>; Fri, 20 Sep 2024 09:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0299613C9CB;
	Fri, 20 Sep 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WeV4/Ant"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD8A13A3F9
	for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824492; cv=none; b=jC2fONB14SXHYrjhL1LaRWE0VzyqWOQL+jji/syIoZ92UGYJfQcFssnKVOKvHXpKF9ktBuyghertGqTQzvKDPQBqEEcwbW0WHOP72RIEXM0mOT+JKJDJOF4NaRDY7Kwjda3DbZMZlHXMGq5UEjQkM2jGLIIvXhkcE4y61c2N0Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824492; c=relaxed/simple;
	bh=Y5Lhb1lEZ1zJkOQ249BuEkfmGYxxn+oEQD4Mg33C1U0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCNK4jPxpFoGvhuwLZWMJ6zbBvT4Kp8dwtUDGXIrC+Cpmxhyexd1uupTzoE+RFv8DmZr2cd9qwGsonFKZiH/k5Lpp10fSKgejJF+PiJeZYageViTYd58gJbXuXS5Y89vz7W4tBn2F3JLyJyk7mz+u2JUtlSLl+19HW4qa19XUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WeV4/Ant; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-205659dc63aso16199595ad.1
        for <cgroups@vger.kernel.org>; Fri, 20 Sep 2024 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1726824490; x=1727429290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5Lhb1lEZ1zJkOQ249BuEkfmGYxxn+oEQD4Mg33C1U0=;
        b=WeV4/Ant8anK6ymmz3ErqlUilpSc1Ql5d8aEE2jGDa3ATyB5tN3dFe6JCpZe7N6s+N
         IX4g5QayvR4Tw5ttqLSm74FBRaA+GRN3nlp+21Iq86Hj4Dq5JaN8EBbgk+9OQHRCCkxr
         DuwoPCSHUSBlVn5/i7H/7+yhxJfZSmYPTArcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726824490; x=1727429290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5Lhb1lEZ1zJkOQ249BuEkfmGYxxn+oEQD4Mg33C1U0=;
        b=lKM8NrCOVX1vV6NxitLNXHZQZLUcI6E6ab9kVSacXSfkcqYOEKyNpCVQUHPBuCbYjx
         6rW4FOoGsRxaD70D9vJyo3uqKNQIBs71j9UkZccLQ+C3iKJ2o7WP2fP6vahpNRGP9rGO
         ZtfhpVcHppvz1H4+D71xLTUDiZCYE/TxWUlWdhV9pNnRUwSneiOac4oBt9naw1z1H2/u
         cwJN+KKCRuxjvJG8l5ZbwirCQzr78NMZXxDnum/0lRIWNnzj0zF8v75y+fyk9oFTuyei
         wiESiqC/BzW4q0dpJrwAWuIla+Rok/i58OyhNbZrUE777GFV52cXjkr/IGZvPZ9ekG/f
         C5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEgUyfMzKSSlrylRT8DlNnBL3mTPnUCp8dwJhJgIhvny2n015pmB8HgYghVrLDItxD1on8kENX@vger.kernel.org
X-Gm-Message-State: AOJu0YyxzL9IJL8Nq8nMHkHAbtyuWieGo5Rj8URaNq0KiGkkYmJ/PK86
	WrLCtky0ONugmKe1MfEwMIN3Kef8IotWs8fohEqONonzQdKyLp8vm6cIvyIhhQ==
X-Google-Smtp-Source: AGHT+IGFdhtqLL0p/NC041FHjjv9PTjEG7ihD72i2Hj/9Obz9C0AtvY6ONBsnIzpaxi1QD136eHrpg==
X-Received: by 2002:a17:902:ea12:b0:206:9818:5439 with SMTP id d9443c01a7336-208d980773bmr22015025ad.19.1726824490364;
        Fri, 20 Sep 2024 02:28:10 -0700 (PDT)
Received: from shivania.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207946d19c0sm91985695ad.146.2024.09.20.02.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 02:28:09 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: pchelkin@ispras.ru,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: chenridong@huawei.com,
	gthelen@google.com,
	lvc-project@linuxtesting.org,
	mkoutny@suse.com,
	shivani.agarwal@broadcom.com,
	tj@kernel.org,
	lizefan.x@bytedance.com,
	cgroups@vger.kernel.org,
	ajay.kaher@broadcom.com
Subject: Re: 5.10.225 stable kernel cgroup_mutex not held assertion failure
Date: Fri, 20 Sep 2024 02:28:03 -0700
Message-Id: <20240920092803.101047-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
References: <20240919-5e2d9ccca61f5022e0b574af-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> we've also encountered this problem. The thing is that commit 688325078a8b
> ("cgroup/cpuset: Prevent UAF in proc_cpuset_show()") relies on the RCU
> synchronization changes introduced by commit d23b5c577715 ("cgroup: Make
> operations on the cgroup root_list RCU safe") which wasn't backported to
> 5.10 as it couldn't be cleanly applied there. That commit converted access
> to the root_list synchronization from depending on cgroup mutex to be
> RCU-safe.

> 5.15 also has this problem, while 6.1 and later stables have the backport
> of this RCU-changing commit so they are not affected. As mentioned by
> Michal here:
> https://lore.kernel.org/stable/xrc6s5oyf3b5hflsffklogluuvd75h2khanrke2laes3en5js2@6kvpkcxs7ufj/

> In the next email I'll send the adapted to 5.10/5.15 commit along with its
> upstream-fix to avoid build failure in some situations. Would be nice if
> you give them a try. Thanks!

Thanks Fedor.

Upstream commit 1be59c97c83c is merged in 5.4 with commit 10aeaa47e4aa and
in 4.19 with commit 27d6dbdc6485. The issue is reproducible in 5.4 and 4.19
also.

I am sending the backport patch of d23b5c577715 and a7fb0423c201 for 5.4 and
4.19 in the next email.

Thanks,
Shivani

