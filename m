Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 110821795C2
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 17:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgCDQyI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 11:54:08 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36262 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgCDQyI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 11:54:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id u25so2311172qkk.3;
        Wed, 04 Mar 2020 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c88Dz2GMYmBaIJfWXLGPh6kIgnpIJOOvRiVNkjl0F5E=;
        b=PrTpbleqZjdc5H+btD7PF3LTHDcueQrwRgAVlPZdUuc+ZYH14SyBvd9/LxxSkDELvJ
         71YSsAm+kuGWjtBbs5qpMqAFEdI05FCAe8lkx3YlMdrXoPGItoqFoab+/mRuS6Pr3dCa
         9PPlaypFNsA5jw4c7XZjFxaM/v2Ne3vjxe3u2Ox2f6hoAxy9l9Ebs8Lvzoc3gPH0fJW7
         M4HeM3dOw1FJ6w2M3o4h6MpZ7tMYNCLBB2+eZkep5tDwsWkxpLeVMbFVoOx1VdTYkseT
         MBAn+E3KpPYWD7T4+/HD8d0pGB/xEp8LNdSo04BT9z+mUBYC7pulu3ubejpjDf97Te5P
         LgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=c88Dz2GMYmBaIJfWXLGPh6kIgnpIJOOvRiVNkjl0F5E=;
        b=VidKBWb7c9JNapmLWqarLyT79zVwrP8DJOzWngxVqggggw5FdbNhkh14pwNC73X1Xt
         piJRXJbTFROeizToqnOG051vksr0Aogc2R4svQFSqriVybuyHPBuBWpEGViVXn80yV7a
         DowwS4Fh7WqcaNfOPLHfkemkBVicx04YRAsgvBDBeB6m/ptqFzSfm/mhiVc6YMFHNexv
         bbFwBFp1COo00RMYjfpGZd+7UZD4sEMHvBRMDQhps3Fml+yjW+6kOpb4uv8pCOPHb3Au
         wJdS37YF5z+fDlcfLyYxeDNUG3laEJmu+qt3mglB6YejX5vy61sukiT6TF5WU1TsVMVc
         2jRA==
X-Gm-Message-State: ANhLgQ3UGIzP0p6ISnfGZ1MnuoxpqDxPi2ljX+e6WKOazFBcNCPsLumD
        0/wtIaiW7N4YjPQOuhKPfFo=
X-Google-Smtp-Source: ADFU+vsX96AJwSm1NN34tV+wgpaH4J4Ama5yloqs452bOiL4yNz32zayD6HbEiGfN4SbE//2DDhVQw==
X-Received: by 2002:a05:620a:747:: with SMTP id i7mr3695138qki.375.1583340847261;
        Wed, 04 Mar 2020 08:54:07 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:16fa])
        by smtp.gmail.com with ESMTPSA id y38sm14734225qth.18.2020.03.04.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 08:54:06 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:54:05 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     cgroups@vger.kernel.org, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup1: don't call release_agent when it is ""
Message-ID: <20200304165405.GI189690@mtj.thefacebook.com>
References: <20200219190129.6899-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219190129.6899-1-tycho@tycho.ws>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 19, 2020 at 12:01:29PM -0700, Tycho Andersen wrote:
> Older (and maybe current) versions of systemd set release_agent to "" when
> shutting down, but do not set notify_on_release to 0.
> 
> Since 64e90a8acb85 ("Introduce STATIC_USERMODEHELPER to mediate
> call_usermodehelper()"), we filter out such calls when the user mode helper
> path is "". However, when used in conjunction with an actual (i.e. non "")
> STATIC_USERMODEHELPER, the path is never "", so the real usermode helper
> will be called with argv[0] == "".
> 
> Let's avoid this by not invoking the release_agent when it is "".
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Applied to cgroup/for-5.6-fixes.

Thanks.

-- 
tejun
