Return-Path: <cgroups+bounces-306-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2E97E77A3
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 03:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54E591C20A44
	for <lists+cgroups@lfdr.de>; Fri, 10 Nov 2023 02:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0F97EB;
	Fri, 10 Nov 2023 02:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZerDZGC0"
X-Original-To: cgroups@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A9A1100;
	Fri, 10 Nov 2023 02:40:53 +0000 (UTC)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B315144B8;
	Thu,  9 Nov 2023 18:40:52 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-4a13374a1e8so688584e0c.1;
        Thu, 09 Nov 2023 18:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699584043; x=1700188843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxBysgLn9vHLOClnPzCM2kRe/JphT5+CEJBZIg4eChY=;
        b=ZerDZGC0hp/gwqavx85/vx9XStbCvs2/I4RTWCNmRXjfbbvN2ia7MLaMsNUjHcXMBj
         QenQlBlmohd3Si1eeaeyxdMC3aEHkAICp8/Rjq7Nv7akGKX7mx6lYyIsa/U2SSlbOd2p
         HE6TyitTw2g2hZ4BUhqnanT/fFQqZYzBMNJ3ELWiaLyYp4uBRBqqO3gnRry1UKbqKVvC
         xtfoZU+TejCJpUWJzNIX8W06FTG4Kc/51+PF924RGmR32nakaJCX8xijPbSrXONXpAac
         TY3u0O62ZuxKzMedbjJBQAYQKKJfl3WD4Vf2LFs2Bi8yJrwljFiTMCO98CDDsBcrBm5z
         Lbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699584043; x=1700188843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxBysgLn9vHLOClnPzCM2kRe/JphT5+CEJBZIg4eChY=;
        b=wVwq/L6esQJepySGGjcR4QTC+GSWNwzW9jaY8ly+6coupUHas+BBDB5ZVgsWD6C5yE
         yJlSijL9IPZsXfMUvcYPZ2odFpCG9+xOz25Jn2xtbztn0vb9wF+nTx1pguB8iJ9J8h3H
         gVwq0Xa5gIW6N2ErdPvJlBOWJfx5B0Sb6a7/4d5Kjqs9skgJrSjjLmiZbik9p6ZSFvjZ
         2OnoEmdEYd0k6DXXfpwIodTbMNykyKKHmMaB6c1W1XUmkhk+T0kOfF3mvCkjBL8JjhEo
         2qL8K5YtX1WhsTBcARspYV/hRx7BNPKPyIC55Vj3p1NErvqHhbwpcr2TNJyDLAN/kN2Z
         KQ1g==
X-Gm-Message-State: AOJu0YzbENwHanyZ24fiaMyG2q4F1ApByqEq5q3kisFXIPau8oceXREC
	++z5M8hgl2gx5xEJ+IOA9puaNXRA078EAhBWCwA=
X-Google-Smtp-Source: AGHT+IGoKl+MKJweI766GjID4tY4Fu2v8MU/htC0NOPIXfXGeJJwvInlVPOfsleHgMIJ3NuY/r7yGx8BnS+INHRpfQY=
X-Received: by 2002:a05:6122:d0b:b0:4ab:f279:ba33 with SMTP id
 az11-20020a0561220d0b00b004abf279ba33mr3604578vkb.16.1699584043661; Thu, 09
 Nov 2023 18:40:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231029061438.4215-1-laoar.shao@gmail.com> <20231029061438.4215-11-laoar.shao@gmail.com>
 <ZU1P9_QU4j-9B_U8@slm.duckdns.org>
In-Reply-To: <ZU1P9_QU4j-9B_U8@slm.duckdns.org>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 10 Nov 2023 10:40:07 +0800
Message-ID: <CALOAHbC7xvDVjZ6H=uwojywRTQCMRpJ4OixP2nRtesZdz84UyQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/11] selftests/bpf: Add a new cgroup helper get_cgroup_hierarchy_id()
To: Tejun Heo <tj@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com, 
	haoluo@google.com, jolsa@kernel.org, lizefan.x@bytedance.com, 
	hannes@cmpxchg.org, yosryahmed@google.com, mkoutny@suse.com, 
	sinquersw@gmail.com, longman@redhat.com, cgroups@vger.kernel.org, 
	bpf@vger.kernel.org, oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 5:32=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Sun, Oct 29, 2023 at 06:14:37AM +0000, Yafang Shao wrote:
> > +int get_cgroup1_hierarchy_id(const char *cgrp_name)
>
> Maybe use subsys_name or controller? cgroup name usually means the cgroup
> directory name.
>

will use subsys_name instead. Thanks for your suggestion.

--=20
Regards
Yafang

