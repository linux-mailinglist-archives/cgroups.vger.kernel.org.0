Return-Path: <cgroups+bounces-4864-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED62976F78
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 19:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0874A2856AD
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 17:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2D21BF333;
	Thu, 12 Sep 2024 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHQENVl2"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D31158DD2;
	Thu, 12 Sep 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726161772; cv=none; b=KPOgyMxRMHg+vUtP55kUle22BYdIubhOn3Z0ozahPokKp6EZgML6yNmWtwpcGg2yeOkYuxYH4D+dch1Mo03E10IiPvImqhVhbaeqtGVzzpRxuyfwW1RVIgLKwb85oucek/E3LqhdRDrm3VmLqOs0SvKFsiQSRiStJK7eMSRnVoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726161772; c=relaxed/simple;
	bh=IWmueW/2HPyG8HWdEpakh5zNGcRdl3p45Wo1GUB0IXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ptBgRh8HtFbTekHKB7QlRLLNjqkYjYbLkdkcK/2fJXVr/bgwZbtlLumcwPavmXhAzdP3qV3VmnWDvC2YkidxpOqzFpmiyPIvkIlFCTG1V/eSm0FIhqwDGA+nyXPhXrytpZRzge2eKRw670l51h3EC02CfrXHXUNy6JcXGcseAx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHQENVl2; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6c3567a143eso9427856d6.2;
        Thu, 12 Sep 2024 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726161769; x=1726766569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWmueW/2HPyG8HWdEpakh5zNGcRdl3p45Wo1GUB0IXk=;
        b=RHQENVl2Zb7UpqF9JjSJt1r95ysydzGCB3e016rUjcLbnBvVMXQebuaNP7NjdntU7q
         Ru6/NPY9IpX6hOY9zUYaJiki5QTJr2bmdlvlON4JhcRud744asElgDBSC2PdMs+Lznqc
         jTy8+7MOoLLnlNaBzAv3BGykyKb3BhwrGqhq0zLV25yrYK+aI+Fay8ei94kByRLB9PgJ
         xn5kMPllg8Ge7ZqE745AQyUSGWIFOWfr8YQe2Of0MoNf2MTL7UvuTw1YLRFptWUfXibw
         c8qXdidSyCCQDacrlYcjIzVGW06mCZztVDy0llhU/4HhJV3ZUlm3I1WNY16ozIyfOt2i
         YKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726161769; x=1726766569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWmueW/2HPyG8HWdEpakh5zNGcRdl3p45Wo1GUB0IXk=;
        b=Su1bWx6rMwE0cNvLcMIBoX3GEQQEvKRPD3H3LT2QP9C0OXjCtejLZkeflnuLvt+YkM
         WgVxVU5mMF20aRxLMBUhTnePnIaOAbq84LeWOF2vCf7Omuds0NQ3Wdo8aENtCzqc/P25
         GMEyJK/JrSW5keFta9i5Z7BaA7+2XeQXRGfsxy0bOGIR23YYp5uz+VUj4cWO7KzflLJ7
         UP2wak6/wGzjOBVRS3GYO/FC3Cw4KIkAGgclZ2sM0Go39T+wsGvJ3XdX4xEaeqW+OfKF
         PMMqmtiGThXfXEqgtYfCAmDBm1EWgKKwie6h/K95lidY7JVIGdvRKSEZ3VtBpcybjuYY
         F8ow==
X-Forwarded-Encrypted: i=1; AJvYcCXI3XXN1l1qIIlg6Yp5u1jCuXpyDj4OATXPxwVEAiGQIj9meOkd7nKGGhjdJ5ds0BZ60U06eqti@vger.kernel.org, AJvYcCXL9Zr3wfdJR6w/6UjP+YSN9mvJEaKflh5rfOG5lvKD/rQ5L6n5thzbwcHbWqaycdNZSpXNuOh1fP2HKG9Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Xg3sfB8lz3qKneFaxepCVEAktiw7uz0yYVGldUlIzBUTGeyM
	TA6KYf3JAyuTb50SGdbncy2Ur8JfVpOzd2coLpZJJWIqPLiHFMdv2fHGJrS6K7L84o0lcelD2Cz
	5aOjJmG5VC6IXp8rOFeKcMV8OleY=
X-Google-Smtp-Source: AGHT+IEqTdFlpeKZGci8It87XbPBnudWtvW8f90wPyEMUDR1KRydLqC2TaXUk8HvnqWpcfFlzaRAjc6k8c9/1PeQy8A=
X-Received: by 2002:a05:6214:3a86:b0:6c5:297c:da5f with SMTP id
 6a1803df08f44-6c573570b58mr64415406d6.33.1726161769448; Thu, 12 Sep 2024
 10:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org> <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
In-Reply-To: <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Sep 2024 10:22:38 -0700
Message-ID: <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mfleming@cloudflare.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:35=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> >
> Yeah there is a plan to remove these.
>
> Nhat, are you currently working on this? If not I can try to find a
> few cycles to address this.

I'm not, but Joshua from my team is working on it :)

cc-ing Joshua...

