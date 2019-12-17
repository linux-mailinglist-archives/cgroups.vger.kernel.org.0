Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 307AB122F1E
	for <lists+cgroups@lfdr.de>; Tue, 17 Dec 2019 15:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfLQOq4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 17 Dec 2019 09:46:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53665 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728573AbfLQOq4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 17 Dec 2019 09:46:56 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so3194020wmc.3;
        Tue, 17 Dec 2019 06:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tO9xCSowUipoQ7W1AR4AKa8ZqnZXGPs6Es0GLJPzMG4=;
        b=IRoB1LuyN3xZcturJXHUAGMtzDjEYCBSOQXVLpusA69ZYTAo474BvPCFfkYpiNy0mA
         7zPlCzIG/XPnVLDmPurFkNqA9kPMAZaPH+V06WBgPJx+HUmImA5Fp9XamHOzPnRlxHg1
         iXbFmSjK41q+RRu9Z+qYdZD8/Akl075zqZ3LGSD6+VhNadwf09eMdMhaZniATepOHyM2
         HnndZlwDZojZLaL4SXtWYQ4vA7soFp5Pv1YgOMGSks6UXh8yaG8jtd9Gyd1dIUjk6J3C
         4d8pYN+/mPuVGKyFF5D1HIvEbgn91JStU2WfMppRYEY9zIt4dcdxWFo65aTxs/PPITaT
         6LbQ==
X-Gm-Message-State: APjAAAXtLuWTlJY2RMsV2cXVnl7EZTXDS+rx/RhZWzOztS2AyMCU0v/M
        ptlmnc6Xi2Y0/dbzOX/SgVk=
X-Google-Smtp-Source: APXvYqyQRDROOdlH8DpI5kAyQN88ZStAn4sknFkwi74VDSblzzh4EemeMlpYs4PM61Jl1NA5Lndw7g==
X-Received: by 2002:a1c:c919:: with SMTP id f25mr5812629wmb.49.1576594013826;
        Tue, 17 Dec 2019 06:46:53 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 5sm26063280wrh.5.2019.12.17.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 06:46:52 -0800 (PST)
Date:   Tue, 17 Dec 2019 15:46:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Chris Down <chris@chrisdown.name>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol.c: move mem_cgroup_id_get_many under
 CONFIG_MMU
Message-ID: <20191217144652.GA7272@dhcp22.suse.cz>
References: <20191217135440.GB58496@chrisdown.name>
 <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <392D7C59-5538-4A9B-8974-DB0B64880C2C@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 17-12-19 09:16:36, Qian Cai wrote:
> 
> 
> > On Dec 17, 2019, at 8:54 AM, Chris Down <chris@chrisdown.name> wrote:
> > 
> > Let's just add __maybe_unused, since it seems like what we want in this scenario -- it avoids new users having to enter preprocessor madness, while also not polluting the build output.
> 
> __maybe_unused should only be used in the last resort as it mark the compiler to catch the real issues in the future. In this case, it might be better just ignore it as only non-realistic compiling test would use !CONFIG_MMU in this case.

yes, I would just ignore this warning. Btw. it seems that this is
enabled by default for -Wall. Is this useful for kernel builds at
all? Does it realistically help discovering real issues? If not then
can we simply blacklist it?
-- 
Michal Hocko
SUSE Labs
