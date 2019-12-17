Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941E0122F9B
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbfLQPEj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:04:39 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38294 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfLQPEi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:04:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id k6so6148106qki.5
        for <cgroups@vger.kernel.org>; Tue, 17 Dec 2019 07:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=KWvMnp6WnFUpycSP8rv3DWkxz/r0qpxVC39yfCQNPZc=;
        b=IYatTteW5y6ti8LEqO+/zdTUGmCv1KDv68bKa61tkxNA/krQNPJ1DcjdPIRpuOQLC3
         CQOpF0MVR3hP3jJVnCgTINdUmiwkvge6ogGB8p+KpBWDIf6ejcEzpsE2U1eNGaPv9sIQ
         GF2AUiR4gIIR/kxu9qTp2EaJ2HYUJgsv9IZXk/PxhrE7pOPhIrGf/0JpEBXcEl3tBWk3
         BErm+rW/yMR4fReQaGo/GSsnxoxkPELI5fdYm2psftBMpuKG1M8MjB1sbfNP/s4N4Wkl
         J8uf4/kz+JjLvRoPmXI0VkUKEv9SwZscKFi+6nhMH/+7bEsK52Pwc6VQW+kOmZVgKMG0
         pEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=KWvMnp6WnFUpycSP8rv3DWkxz/r0qpxVC39yfCQNPZc=;
        b=au4ojpjyssXPWW9e2M4MIMjJWwqqHAt7UZThurkPB88JWlpHWON1OYRV2bm9CTyfaN
         0+Le5I2sfIQBQ9hsFcjDcqI9TpSNI/OOEx+ydOhXpikApl7H627oz4d1A1Zu1ZGGkFWY
         Otj3u1g2SWmVJSmydCmNJK2/3s7SCR3MCz2bDiGAhVHYYhvWxQTELn5fDf4NuQXB5lh8
         8+Kd9u67fcSb2ozVndNBA6IIk+NchDF7nYyxRwhY5Ch5OIcu8IJ+GKih8SwoFaU7rtCe
         hUkc5udI4M+A+jJc3kgVLQcjU8po2C1BuLIuZgrXKlNXJrSOVLa1Q6MU7f3ML5dduL7j
         0ZGw==
X-Gm-Message-State: APjAAAVvdBCvaBelGGLw2p0s0vVdb4dN9V2o6XjMgbx+lBChO7+J2LAD
        0mtNh+oXL2ES6i6RJamCpSr0kA==
X-Google-Smtp-Source: APXvYqwB3tefmBijBbhtpmgp6Z8XZFIqVXA5SBPXcJUiqBJ+dz6d2gWsnzuhtCFCOn9Z/7d4kKYFSg==
X-Received: by 2002:a37:96c2:: with SMTP id y185mr5834810qkd.202.1576595077972;
        Tue, 17 Dec 2019 07:04:37 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 13sm7050492qke.85.2019.12.17.07.04.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 07:04:37 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under CONFIG_MMU
Date:   Tue, 17 Dec 2019 10:04:36 -0500
Message-Id: <43881F9C-90D0-4DE0-BA1E-B74ACF8567BD@lca.pw>
References: <20191217144652.GA7272@dhcp22.suse.cz>
Cc:     Chris Down <chris@chrisdown.name>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191217144652.GA7272@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org



> On Dec 17, 2019, at 9:46 AM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> yes, I would just ignore this warning. Btw. it seems that this is
> enabled by default for -Wall. Is this useful for kernel builds at
> all? Does it realistically help discovering real issues? If not then
> can we simply blacklist it?

-Wunused-function is useful in-general as it caught many dead code that some=
 commits left unintentionally with real-world configs.=
