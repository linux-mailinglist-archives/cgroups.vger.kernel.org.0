Return-Path: <cgroups+bounces-5146-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1569A1072
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 644C11F21FF1
	for <lists+cgroups@lfdr.de>; Wed, 16 Oct 2024 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AD18A933;
	Wed, 16 Oct 2024 17:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TvNrxYqO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9A188580
	for <cgroups@vger.kernel.org>; Wed, 16 Oct 2024 17:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729099058; cv=none; b=EhbWArS+B0ppLz6mydd4P+p+UA2Cf15BC2Fv4DdM0LdaeJ/7vtHCGyMYCXPFl0OItuN4eMrhdrK6F++/AzSVXt06qRFEplvMSdMQJ8plk5gWnDG8XkuUXSSQOWwNeiY/77iHjbo+9y/yyfyj5QDvaXtRJLCrkeCySru5J8wln0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729099058; c=relaxed/simple;
	bh=1qcDEKEXdEe+vXVETIwM5sey0mOwmtEmxTAsdaInNAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWQh44gLu0IPwomHbLvaYZz6VRpGtbz3VbWFzK2qrD0EXzR9BOKJlB675w8IzkHdj+0gSjiUI/N3L0sRCtebTGx4d1uo9qVO6RxvNqrzl81GLBv/WEmUpScIT3D1RqIhH2Ul2Oh9gsWSQcdLfIFs2pRf+Fk/7AutpqydiHiV80w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TvNrxYqO; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608dddaa35so16921cf.0
        for <cgroups@vger.kernel.org>; Wed, 16 Oct 2024 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729099055; x=1729703855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6N/pHBmZnFXpVq6+UL3T9SWfEc3WQ8exbB8tpXp45E=;
        b=TvNrxYqOY9m5dmlF1slyChDCFfA9jaz2iU0zRxrxaMA0jBXaAzcP7MXgc9RIBIuyz+
         FjcM5FEME5GXlkPqxhKa4BIZWx2aE3E68YQCSsT9jbbCmc1kCu4dY+XH6iVPmU1FeP1O
         06gHphuJhDx0X1V6UX4wW6WOZOdVqukZfBQtNrMWniF0o4uQjGrBiPQOPBAmjl/eCJDF
         2ErUcbnLkZYlf/vgtiQENN0ZRDnHf+k8udDQdXfRCGYZ2NaO6i6vVKKhlnjY5qc+e6BR
         3cZKyR5eJqRLyk29cHugoIJU8kg4oON3UDiHoR0/cVjL0hUWHkxVKhawTuAhHD5x94xJ
         5SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729099055; x=1729703855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6N/pHBmZnFXpVq6+UL3T9SWfEc3WQ8exbB8tpXp45E=;
        b=pgcG4dGzKew4Py0pzEqEe3a2zYTtAmXcmvfzYiLYaVpQeVVr+5G84jCfWlMVIUKO7c
         VPqEbe9/1ZArVE5Rejf/urk7E21ImCwlyz3mwpC44vAdLl0KHnkyEL31uKdmDqfkpQRP
         mpVrxhUc8yJsXI5dSfDAZ3bFLmn9MM+v8q8f/ZqVvMiZtzFacjFpaxtnCoatsFzGbQfk
         t4iFyLhxCn+Fy7ekiAmpfEoKl/NEMQRo459GQtJHbJcJzUEr1rxija0fQFmTE8ItevXD
         fphoB8nOOS5/MbJSFZZqF7b+++17fPd2o8ccKOLhM/ohCW0Nyo18B94uVJQ383hqXvyY
         M1vA==
X-Forwarded-Encrypted: i=1; AJvYcCXo2nz2DTvE/scFM0fg+97FZOyEKm/cv0OnKvlHA/yLyMw8ljQl4HSnTJaTew3K8tm6rn42FfCE@vger.kernel.org
X-Gm-Message-State: AOJu0YxYbKTh7BGrg08IcexDdMqadbK0FS8yPdr2smjHIY+NvO/MZUQ0
	zlwsotTYa7K+1Hpzjnw91Nkvrup2rWpxcMrGcVrgjB+D3wUucjMME10u0bdGOR/678+Y4TeQ0Gh
	8HVYmA2N2i7jfFQH2fPLpCPDeuhxBf1p3An/P
X-Google-Smtp-Source: AGHT+IEePLBNjlQIEzNDgfNbNMSxGyKJwTaLZWj25xyJ0R8z1vqkjzL/pzKBBv0CgTEy+r6lEoCb5QFBcNuwTz3HKxI=
X-Received: by 2002:a05:622a:a7c7:b0:460:48c3:c352 with SMTP id
 d75a77b69052e-4608eaa4aa8mr5488141cf.1.1729099055385; Wed, 16 Oct 2024
 10:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015213721.3804209-1-shakeel.butt@linux.dev>
In-Reply-To: <20241015213721.3804209-1-shakeel.butt@linux.dev>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 16 Oct 2024 10:17:22 -0700
Message-ID: <CABdmKX3iqmPnmSDi=KCy+0QSws+PjLR1jLs8HL-JjorCARM02A@mail.gmail.com>
Subject: Re: [PATCH v2] memcg: add tracing for memcg stat updates
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	JP Kobryn <inwardvessel@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Michal Hocko <mhocko@suse.com>, 
	Muchun Song <songmuchun@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 2:37=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> The memcg stats are maintained in rstat infrastructure which provides ver=
y
> fast updates side and reasonable read side.  However memcg added plethora
> of stats and made the read side, which is cgroup rstat flush, very slow.
> To solve that, threshold was added in the memcg stats read side i.e.  no
> need to flush the stats if updates are within the threshold.
>
> This threshold based improvement worked for sometime but more stats were
> added to memcg and also the read codepath was getting triggered in the
> performance sensitive paths which made threshold based ratelimiting
> ineffective.  We need more visibility into the hot and cold stats i.e.
> stats with a lot of updates.  Let's add trace to get that visibility.
>
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: JP Kobryn <inwardvessel@gmail.com>
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: T.J. Mercier <tjmercier@google.com>

