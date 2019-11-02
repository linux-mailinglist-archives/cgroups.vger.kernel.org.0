Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0E2ECFA5
	for <lists+cgroups@lfdr.de>; Sat,  2 Nov 2019 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfKBQCz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Sat, 2 Nov 2019 12:02:55 -0400
Received: from mail-ua1-f103.google.com ([209.85.222.103]:35743 "EHLO
        mail-ua1-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbfKBQCz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Sat, 2 Nov 2019 12:02:55 -0400
Received: by mail-ua1-f103.google.com with SMTP id n41so3794638uae.2
        for <cgroups@vger.kernel.org>; Sat, 02 Nov 2019 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ef9ou+qj0vagMx1XNPM66HwZ5oa8tbdOa32pNN49rmM=;
        b=LvJWdLOfXa28+18z0vfIwt2vXO10BiJMLLj1cghAiBcYuUCfXtVKu+qQDkJuNiIsv2
         eg1QR09wz+rMzdgxFRcKQZHEuFmmsjf6ywdbbgGETt88yEgQvC3oFTsM6E2Ex0iCrTv1
         QcSSJgi0P+WBF8w8p3kW1exS+wO22ORwxawtc2wMk2xBPZS/Bf64+msLGc/BYX5H+xs8
         V7lPow+YCJoRbFlqGt3uBDaIQt9FpU6i4+/vE5m4j4Hd/ajoaeCjlywmBpqxCB+rbjKZ
         FecRb5+ftAldNmWA7D1jiQftbb2nUm3LlxyP/8W3YTmIe37KgZZqFlAn1lbQI8nlTl4V
         u6aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Ef9ou+qj0vagMx1XNPM66HwZ5oa8tbdOa32pNN49rmM=;
        b=buEEPVRc7bpVVLEGgNdFsccasxfeMc1jYo8ZQ+aNIvc7JWAglQ0ZAgAQoAkqzTcNtC
         k7GPucmx2qugNK7jOWN6SEJcirD6iivjgeGs1nkswANv1aSG5RI1lRChYMQ761Ue2OXF
         3MFQezL2C3n4s1oIKLbW6VS8MKk9e0GAkvNTPO3fOwUvFDbdfwzzpiwye3Vx/n6gKBd7
         LHB6cWBAn9hsiZoEtOgdlvBnvUdZUvziU7Ua4HXjT+dFS/3W0+LM9+EYzUJ5BIR71Uxv
         lwE7bnDjquHaIji5j2w4buS0+N/90yduvInvjbuXm7PA4v4Ul94CF6QBovn2t/vZH8GO
         mblw==
X-Gm-Message-State: APjAAAVAORYIbzkHBjnAb2bxx2c0+TKi8gf10ae1X9BMoA7zri+PrwYJ
        nHxRTOj+Cleuwu9lJK1dGEtnzvTsoTss6Ki7qIWogCm4QJxqPg==
X-Google-Smtp-Source: APXvYqwK1xgX5mnhSKjTMChk8ZE8+bx2G7d8kJb50m9VZnFRyUHlvIALEEITytHRFgZmXCB2+L8VVq1/W6Zv
X-Received: by 2002:ab0:6044:: with SMTP id o4mr6464044ual.119.1572710574360;
        Sat, 02 Nov 2019 09:02:54 -0700 (PDT)
Received: from familie-tometzki.de (freebsd.familie-tometzki.de. [18.210.29.142])
        by smtp-relay.gmail.com with ESMTPS id j184sm1051649vkh.1.2019.11.02.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 09:02:54 -0700 (PDT)
X-Relaying-Domain: familie-tometzki.de
Received: from freebsd.familie-tometzki.de (localhost [127.0.0.1])
        by freebsd.familie-tometzki.de (Postfix) with ESMTP id 70195278CC;
        Sat,  2 Nov 2019 17:02:53 +0100 (CET)
Date:   Sat, 2 Nov 2019 17:02:53 +0100
From:   Damian Tometzki <damian.tometzki@familie-tometzki.de>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/memcontrol: update documentation about invoking oom
 killer
Message-ID: <20191102160252.GA19103@freebsd.familie-tometzki.de>
Mail-Followup-To: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
References: <157270779336.1961.6528158720593572480.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157270779336.1961.6528158720593572480.stgit@buzz>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, 02. Nov 18:16, Konstantin Khlebnikov wrote:
> Since commit 29ef680ae7c2 ("memcg, oom: move out_of_memory back to the
> charge path") memcg invokes oom killer not only for user page-faults.
> This means 0-order allocation will either succeed or task get killed.
> 
> Fixes: 8e675f7af507 ("mm/oom_kill: count global and memory cgroup oom kills")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |    9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
> index 5361ebec3361..eb47815e137b 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1219,8 +1219,13 @@ PAGE_SIZE multiple when read back.
>  
>  		Failed allocation in its turn could be returned into
>  		userspace as -ENOMEM or silently ignored in cases like
> -		disk readahead.  For now OOM in memory cgroup kills
> -		tasks iff shortage has happened inside page fault.
> +		disk readahead.
> +
> +		Before 4.19 OOM in memory cgroup killed tasks iff
Hello Konstantin,

iff --> if :-)

Best regards
Damian


> +		shortage has happened inside page fault, random
> +		syscall may fail with ENOMEM or EFAULT. Since 4.19
> +		failed memory cgroup allocation invokes oom killer and
> +		keeps retrying until it succeeds.
>  
>  		This event is not raised if the OOM killer is not
>  		considered as an option, e.g. for failed high-order
> 
