Return-Path: <cgroups+bounces-7246-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A91A73DBA
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 19:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D746A7A4903
	for <lists+cgroups@lfdr.de>; Thu, 27 Mar 2025 18:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0189D21A437;
	Thu, 27 Mar 2025 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0uXjl5rw"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD22192E1
	for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743098877; cv=none; b=j5+07Q6TgGk/k0ymALQm7OruPxIIkbOZJnT8i20zHgepG5mkRceEIh/sGtgXbeB7dYSEvt36Z3MYDZyAOiSyHZzKxvbyx+s2PAx8gdqbzflWWEOnKld0tBL6inJzEPg12OApKoHyQUS4qmEMZIfbn6mpaUmyk+Btz1hOwqfsMnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743098877; c=relaxed/simple;
	bh=FFw5jVGVjWP/GUcE+gD57gEpEJu0gzTYL/Vm74NKgAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gcikOasb+cylTKv7NU/qNaDSerqByhzW3IXkPtxOWxE0KQDXpSmemxN9+M35lPYIIxPlyU3CVIWpXAfAp1Q/v0VEKL6SQiG05c0VjRHFn/Bezp3JRCugxeZodwEUBAUc+DFkq7UO9IfnVM2ZbXuUBhe7EBoiaF5ylC5QcxMaOY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0uXjl5rw; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6e8fae3e448so23834736d6.2
        for <cgroups@vger.kernel.org>; Thu, 27 Mar 2025 11:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743098874; x=1743703674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNHhGbcNFe9IvxKegRUJgU6d0SStVr5clQydvbl1alA=;
        b=0uXjl5rwxVBQhweW9GwBi94rXFQmmkxoO2AAeTIBnZd40lrIqaxCtr3ba2Qn56xRRL
         Bflikq4fbnPrBFQlVE0qHj5r9nI8+KidyPNxdxijKukRkf80kjwb8T0Bw9Ughfbb6VoZ
         z5S/LskWMppf3wiZBf5IEDhTcOvIHaAHgdGSu7iF/Deqw6gFsYVFXuFSsT2zxPzpBY+J
         g2RkffkvQNbhKxLIFAdRnuiPu+4jYxmVQv5oMTRPKAWnzPI5xkCBbSrrSdJjrrtUxwQu
         /1A1Mf3f8xyhf0l3kJaW2kTLyt42RLp/tWYNYwS/Ce2MZs0whWd9IGeiO6JC8CO2PzXe
         SnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743098874; x=1743703674;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FNHhGbcNFe9IvxKegRUJgU6d0SStVr5clQydvbl1alA=;
        b=HCrnl3+PLBAb1ocmBIB9aYytqTvFXfeiN0w+Rm/6ATR6aLZoY2GnOCPHyozRp3DocP
         P+eDZXvWx8dRUSGpl+aucj9ZgjtCBC0iU2kA6TE1yekkOqG+ZBS6R8uv1Tz8jhF7/L+t
         6l715b1Cv2tM8s/l61kI6FM148bRWC0r7oTdBWzd0SReC77RrUjUy5xFJmXC453kAJrO
         h5JCHUAHkuydirKbqrftE6yvjRqnmmtYkmCD/Ofte1usoMLi+yoXJ1fk0Q4rkHLrFGIM
         VlaNqpsmc0x3wYSHAGJGXjXPuljfZ/OKrvOUp6aJ+i0NluwNAPa/UBJ0rYwjTwMSfbnJ
         /UnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWICWAwDcMhsVn1s9Il/nz7wdnq+tVeepuZiVzTLayBGbZazWTXgKN5OYYdoEkK7q3BBVrCwzR7@vger.kernel.org
X-Gm-Message-State: AOJu0YxoNzxYQb4+ZgAEjLphCrWCJy8bYfCe/OuhOxByxdPxaopD8niR
	DJwpEG/F9fnWTrvw+JVqOHygzyIe2W0ACUPFvWnEn8X4DTeLmJhzhujSpz9U0VN2Ytu83sISlny
	cQ4sjzZkmajX+wkweqA==
X-Google-Smtp-Source: AGHT+IHhR1AcX7MOyjilKRGwXaffZLhxfuTjulaccN51vv9gMpKZONM4saJU+yWDYPnnHE9lipgeoqVqPn+NMSdW
X-Received: from uau11.prod.google.com ([2002:a05:6130:634b:b0:86f:fad4:5337])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5a94:b0:476:a967:b242 with SMTP id d75a77b69052e-4776e152be4mr95011791cf.30.1743098874436;
 Thu, 27 Mar 2025 11:07:54 -0700 (PDT)
Date: Thu, 27 Mar 2025 18:07:51 +0000
In-Reply-To: <fg5owc6cvx7mkdq64ljc4byc5xmepddgthanynyvfsqhww7wx2@q5op3ltl2nip>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <fg5owc6cvx7mkdq64ljc4byc5xmepddgthanynyvfsqhww7wx2@q5op3ltl2nip>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250327180753.1458171-1-jthoughton@google.com>
Subject: Re: [PATCH 3/5] cgroup: selftests: Move cgroup_util into its own library
From: James Houghton <jthoughton@google.com>
To: mkoutny@suse.com
Cc: axelrasmussen@google.com, cgroups@vger.kernel.org, dmatlack@google.com, 
	hannes@cmpxchg.org, jthoughton@google.com, kvm@vger.kernel.org, 
	laoar.shao@gmail.com, linux-kernel@vger.kernel.org, mlevitsk@redhat.com, 
	seanjc@google.com, tj@kernel.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 2:43=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.co=
m> wrote:
>
> Hello James.
>
> On Thu, Mar 27, 2025 at 01:23:48AM +0000, James Houghton <jthoughton@goog=
le.com> wrote:
> > KVM selftests will soon need to use some of the cgroup creation and
> > deletion functionality from cgroup_util.
>
> Thanks, I think cross-selftest sharing is better than duplicating
> similar code.
>
> +Cc: Yafang as it may worth porting/unifying with
> tools/testing/selftests/bpf/cgroup_helpers.h too
>
> > --- a/tools/testing/selftests/cgroup/cgroup_util.c
> > +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> > @@ -16,8 +16,7 @@
> > =C2=A0#include <sys/wait.h>
> > =C2=A0#include <unistd.h>
> >=20
> > -#include "cgroup_util.h"
> > -#include "../clone3/clone3_selftests.h"
> > +#include <cgroup_util.h>
>
> The clone3_selftests.h header is not needed anymore?

Ah, sorry.

We do indeed still reference `sys_clone3()` from cgroup_util.c, so it shoul=
d
stay in (as "../../clone3/clone3_selftests.h"). I realize now that it compi=
led
just fine because the call to `sys_clone3()` is dropped entirely when
clone3_selftests.h is not included.

So I'll apply the following diff:

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testi=
ng/selftests/cgroup/lib/cgroup_util.c
index d5649486a11df..fe15541f3a07d 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -18,6 +18,8 @@
=20
 #include <cgroup_util.h>
=20
+#include "../../clone3/clone3_selftests.h"
+
 /* Returns read len on success, or -errno on failure. */
 static ssize_t read_text(const char *path, char *buf, size_t max_len)
 {
diff --git a/tools/testing/selftests/cgroup/lib/libcgroup.mk b/tools/testin=
g/selftests/cgroup/lib/libcgroup.mk
index 2cbf07337c23f..12323041a5ce6 100644
--- a/tools/testing/selftests/cgroup/lib/libcgroup.mk
+++ b/tools/testing/selftests/cgroup/lib/libcgroup.mk
@@ -6,7 +6,9 @@ LIBCGROUP_O :=3D $(patsubst %.c, $(OUTPUT)/%.o, $(LIBCGROUP=
_C))
=20
 CFLAGS +=3D -I$(CGROUP_DIR)/lib/include
=20
-$(LIBCGROUP_O): $(OUTPUT)/%.o : $(CGROUP_DIR)/%.c
+EXTRA_HDRS :=3D $(selfdir)/clone3/clone3_selftests.h
+
+$(LIBCGROUP_O): $(OUTPUT)/%.o : $(CGROUP_DIR)/%.c $(EXTRA_HDRS)
 	$(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
=20
 EXTRA_CLEAN +=3D $(LIBCGROUP_O)

