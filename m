Return-Path: <cgroups+bounces-8775-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4402B0A881
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 18:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705FA3B917E
	for <lists+cgroups@lfdr.de>; Fri, 18 Jul 2025 16:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803452E6D04;
	Fri, 18 Jul 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mfuh6kjA"
X-Original-To: cgroups@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348BC1DED53;
	Fri, 18 Jul 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856496; cv=none; b=TrcgGTJjeyOvLg4vRGDXg7jJvN3HoaA5EToMTWOLMV0tQVnaymzvylsadtEyjXvRlRaHom4eqUqymYlra6McFsau/Mb4RM8Hc4jy9T334CSp1eVacrADoiPQDkUlJHM4BTB3Ca9eXZQiiOWTfjKdFQ4CdH326GqtBsD8Jo8wfeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856496; c=relaxed/simple;
	bh=m6knOuSYcIlxKsVGffC248H2gtrpIHat6jv3oJ7Zdfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dj51r2UfagrAMpPX5r1jM6J3IyFuBIIfVUPuvaCCoJyPSG65TV1LOdO6b/MyTbbC5cWThrkWiAvYt8fuDu7fLFyGTi+aXFxW4aXauWiD3rxj5e+5wEe7kZukMTVPAUbsGitXafOY5Cpq+Y4oum8/WrD84AU/xItN2jJWJG1Giow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mfuh6kjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA546C4CEF1;
	Fri, 18 Jul 2025 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752856495;
	bh=m6knOuSYcIlxKsVGffC248H2gtrpIHat6jv3oJ7Zdfw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mfuh6kjAvD7umLIPydE3Nky3WtUPHH+Xl8RnyHZitxVh9lQ7TzH/WvoQ1hn8dThry
	 qQOreH+1/F1l0p0pKxW2AWpEqbox125oGTtWydyUSSLNn77NSafZSwOvfoRv1TdM6A
	 rHhkoTSQ25epJ5wgQffXkJlqtQE99cnNRBSFOt4pN9YmkfqHqCNkRsgGzY54mNatZz
	 tifFCzd2d7HbmP3Nu/wTxqbhqdhFxGmzFKJ0RG3qDHv8cgEUsFvcdL+5rZim/a1H9t
	 YzonWhgyRK2Pp05MEmxD5TyRWEg3tRD4ppcXwtj2LFkY7Tu2jAIOMycnP2j5eQ1MJx
	 c8nm53A9ZA16A==
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-41b357ba04fso1047002b6e.2;
        Fri, 18 Jul 2025 09:34:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0D5PX7MvLoF/bfbB9Z2mQOxLZ27CnlyeZSLC9DCvEwhU3szlOSzM7LR3zh/IFWW5q8b2you3wp/bvPxvf@vger.kernel.org, AJvYcCV6lTpg7tmMyMrXXgWw34iLygS+YqzT1uenFJzGRwhX3Sz9GZhPxsNJgG7TmRwrocwTOym932kv7EI=@vger.kernel.org, AJvYcCVzwMBV8wGhmZgV6Ln1r6AznG/fb75Ai7ssWcDpf8MPQQ4V1B6SD2yZZcwtwPqwIR4LjPzwe5KP@vger.kernel.org
X-Gm-Message-State: AOJu0YzrNDqah2lXbtuxfgAFNkPCRniFG73J0QrBlK3XLYU8kFazI9fq
	tFMXe9gDeSHJxUkJMWDPB4UJNFW2/okE9KBdVHdBsdhDtj/mTsAl/P1LahdW9W5JdvINbCvmkd6
	O/9ttEsL+XAuWKedQkKaMMEgYBtUB8nw=
X-Google-Smtp-Source: AGHT+IEojOoqgBFZ0afEFLOP+FWBmBL6fAX4RoJ2+7HhbfwIwUGU/AkfIopUbPVIMB4qPTqIJq4u8eyboD2bxFJjais=
X-Received: by 2002:a05:6808:81c7:b0:41f:79f9:1b6b with SMTP id
 5614622812f47-41f79f9201emr2508693b6e.34.1752856495138; Fri, 18 Jul 2025
 09:34:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085550.3828781-1-chenridong@huaweicloud.com>
 <20250717085550.3828781-2-chenridong@huaweicloud.com> <CAJZ5v0jnUQJSBbYWfmGb6wr_CY3j61TSq_cR9KBMqtvxWrmsaA@mail.gmail.com>
 <aHlKabRMHvnSmtwg@slm.duckdns.org>
In-Reply-To: <aHlKabRMHvnSmtwg@slm.duckdns.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 Jul 2025 18:34:44 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g-w19PgueOUmB+sowa-So2ozZS6teOikevt+w3z8mXFg@mail.gmail.com>
X-Gm-Features: Ac12FXyz4ykfYkutx3sWpVr6YP2PQ7V3lwUpdEB13RZOJ0-VC0ytnVswGr8kMzY
Message-ID: <CAJZ5v0g-w19PgueOUmB+sowa-So2ozZS6teOikevt+w3z8mXFg@mail.gmail.com>
Subject: Re: [PATCH v2 -next 1/2] sched,freezer: Remove unnecessary warning in __thaw_task
To: Tejun Heo <tj@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Chen Ridong <chenridong@huaweicloud.com>, hannes@cmpxchg.org, 
	mkoutny@suse.com, pavel@kernel.org, timvp@google.com, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, lujialin4@huawei.com, 
	chenridong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 9:09=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> On Thu, Jul 17, 2025 at 08:26:26PM +0200, Rafael J. Wysocki wrote:
> > I can apply this one, but I'll need an ACK for the [2/2].
>
> Ooh, I just applied the two patches as the original patch referenced went
> through the cgroup tree.

No worries then, I'll just leave them to you.

> If you'd like to route it, I'd be happy to revert them.

More work?  Nah.

