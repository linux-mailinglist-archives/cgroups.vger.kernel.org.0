Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D75122FFD
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 16:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbfLQPTe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 10:19:34 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38499 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbfLQPTe (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 10:19:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id u2so3596394wmc.3;
        Tue, 17 Dec 2019 07:19:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4zEQ83F2qGoC/F92fA9F7HDEhihvKc7tNEjbPfQsODw=;
        b=LuZJfxArESzZXf0+Bf4L3MVHeODbImPQkqXtlzdqkAYhsBJJITn5s6d+jeXXNRGrGB
         EnG23JzgKmw9+SFlw73blctygtExI2+lUZffXvyus+EuKQuC1d8X8TbTHCl2m9pLz2T5
         YEWmE0VVKY0m8EFnya4pO6yjzUh0X3/HSY5ETPRYkC/1vrhj8M6Kcy35eGgNok7IdB6Q
         +9nkCa6NOCN5X9ozE9FC5CnIG9XRRstLZATia1LUNBMhQN89Pn0dQ7n7+qlmCJqaEaJU
         1Ohi23/kkUh2fZ6yrlwh2c1ViAS4iqQAJohkkBBHoUGEDFXPSuGZ1V+GXV2DxEvVI3VU
         ic0A==
X-Gm-Message-State: APjAAAVRpOAlsUkF1uKF4u7IHLVO2k6PmWOxDB3SYeiQefJZnuGteGXd
        MKRHkIWhX7Q8s5naoS9fS9Q=
X-Google-Smtp-Source: APXvYqztX/vQknATUnJPGuoDhEQMMAkKQ4QrJJ9k4b4XynST/j+I8Qhac3CMutXvlAw3+85wIvzcjA==
X-Received: by 2002:a1c:ddc5:: with SMTP id u188mr5787814wmg.83.1576595972595;
        Tue, 17 Dec 2019 07:19:32 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a9sm3347964wmm.15.2019.12.17.07.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 07:19:31 -0800 (PST)
Date:   Tue, 17 Dec 2019 16:19:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Qian Cai <cai@lca.pw>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217151931.GD7272@dhcp22.suse.cz>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
 <20191217144652.GA7272@dhcp22.suse.cz>
 <20191217150921.GA136178@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217150921.GA136178@chrisdown.name>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 17-12-19 15:09:21, Chris Down wrote:
[...]
> (Side note: I'm moderately baffled that a tightly scoped __maybe_unused is
> considered sinister but somehow disabling -Wunused-function is on the table
> :-))

Well, I usually do not like to see __maybe_unused because that is prone
to bit-rot and loses its usefulness. Looking into the recent git logs
most -Wunused-function led to the code removal (which is really good
but the compiler is likely to do that already so the overall impact is
not that large) or more ifdefery. I do not really see many instance of
__maybe_unused.

-- 
Michal Hocko
SUSE Labs
