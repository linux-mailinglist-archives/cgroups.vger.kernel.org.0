Return-Path: <cgroups+bounces-4237-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FD0950E18
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 22:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93CA12840BB
	for <lists+cgroups@lfdr.de>; Tue, 13 Aug 2024 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A37B1A7049;
	Tue, 13 Aug 2024 20:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6VWNOfY"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7F83B192
	for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 20:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582075; cv=none; b=qEJGi7GVgb9U4ViCbmN8Ft5IOK1zd66yV7qmfoanfQiMtTlWNsIw1ogFxXS+TAaS8ypHagthWIZStt15gix9cZ0XmAwLloZeDFfNMVp3n9jZEUV12vBPESkvO3TPt+V4pNml/Ys34DUuAz0ojSB3bxhGQNwuXg7UvrWYhDx5ib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582075; c=relaxed/simple;
	bh=x8+0SHcDmVGIqKZHn79dfKmGygZtA2zzr59rfOJVeY0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PqY3D+oKfGHcamvDkZI3TNWS5vDEPdGM9iWRCfZT7YfER9sUIGglerK3ILDyrKYMZf1nDyaZqAOjegOB8i0YQz7fT4bxlQe/HPVZqv8Zd2wQga29CaVRiFWoMd8/oHghclcXCoW0dLsbRtY+A2vZJrAfSzitOYJBotrQ9rMBBCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6VWNOfY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6688c44060fso136690057b3.2
        for <cgroups@vger.kernel.org>; Tue, 13 Aug 2024 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582073; x=1724186873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6VTAXcSzg2nJxUF/QOoTMCzcY75N5+KjH45iaTDlnBg=;
        b=j6VWNOfYgpptKR0mePrlKzNq4RsmgwAa0iDL8zfyx9k0cFtydGL4fy40hsDzaw0nwm
         /a1XRfpHgLGWHId0TZEyoFLL1XYrdbmf6WrKdI+Rqx2PGGOq4DnQLmtGsfdaO8qAqHtb
         T47A1jB49KPMltSCbjr7M10KyWmovOtYg4Yrj98GFjk6MbJJAe/tMJfTnhcjnbthEjqn
         KmhmbV0VwS1B5wWq37uMz7sdd0gIR4PGGdeDdIotb0zlzKE6M97gVR9FQ7FvKlRkrMyX
         paYPHZ/ASwJDEr7shIHL1dNmqbHmCeJ8tUeHN+A+VTh9TE+Kxx7/kZ2k8JWIsVaBXly5
         YB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582073; x=1724186873;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6VTAXcSzg2nJxUF/QOoTMCzcY75N5+KjH45iaTDlnBg=;
        b=wTSYCV2Wjbfh3SzdqisZU4Imw0RLu4Gtb7EgTXafwv9uG4P2/lgjKVZ4wguJbiER7W
         gNcXSxu8+vK4DGxRyeJpY8mcgi6Fnm8WVo3G+qiInUtUh2vhx4e0DuqTBQw5Jz6Dq+Xm
         OWgv4SxTAs11KlqLRIp1e7KFgthMO84yFCU/Z7kvrx/1aO0utL3V/7gUo0RO5be209n0
         QWQ2h4nFe6FpgzZ0C9tM7hprH7fhCykzHKMX9s10xF79KMmWgiMhyC7r9z1tR9+ETqjk
         dPwo7AvyXi8VY6u/v/6ipt2MDFTewyj+NIElaT/hev3YtcnE8lR34cNnIIBK+rFAstYc
         Br5g==
X-Forwarded-Encrypted: i=1; AJvYcCVDkRLQYjSIQ7kyr1MFNiMqU8nkasVfYwELVXZu8Q+EhC5R6lhFBtkCtsFwOooLgUv9biPvKP/K6375gGYUh9eo0X5nZIssSQ==
X-Gm-Message-State: AOJu0Yw/Sx/e40hD2oCoKb/Biqq7MjhxK47qgvWCJblR+GKYYTWg9Dn5
	NpsjWqxweE/H4hE837xHswdKt+P8o8h2xnfuYRuQouWkuoEIIQhZv/h9XrOMd30XSiNq79Sc3TK
	lWMMISet+ww==
X-Google-Smtp-Source: AGHT+IFzblsx6HVwSONVyuq1qq/U8tF5umc8wK7YjkPphN9wlYyR7AcobNhp+giR2cU9kqZsxLwEY6K/rtnFFQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a0d:d385:0:b0:673:b39a:92ea with SMTP id
 00721157ae682-6ac997f8a9cmr286847b3.7.1723582072721; Tue, 13 Aug 2024
 13:47:52 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:10 +0000
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 0/5] Improve mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Incremental cgroup iteration is being used again [1]. This patchset
improves the reliability of mem_cgroup_iter(). It also improves
simplicity and code readability.

[1] https://lore.kernel.org/20240514202641.2821494-1-hannes@cmpxchg.org/
--

v2: add patch to clarify css sibling linkage is RCU protected. The
kernel build bot RCU sparse error from v1 has been ignored.
v1: https://lore.kernel.org/20240724190214.1108049-1-kinseyho@google.com/

Kinsey Ho (5):
  cgroup: clarify css sibling linkage is protected by cgroup_mutex or
    RCU
  mm: don't hold css->refcnt during traversal
  mm: increment gen # before restarting traversal
  mm: restart if multiple traversals raced
  mm: clean up mem_cgroup_iter()

 include/linux/cgroup-defs.h |  6 ++-
 include/linux/memcontrol.h  |  6 +--
 kernel/cgroup/cgroup.c      | 16 +++----
 mm/memcontrol.c             | 84 +++++++++++++++----------------------
 4 files changed, 51 insertions(+), 61 deletions(-)

-- 
2.46.0.76.ge559c4bf1a-goog


