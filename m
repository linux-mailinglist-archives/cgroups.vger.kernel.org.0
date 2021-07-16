Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D7E3CBA6B
	for <lists+cgroups@lfdr.de>; Fri, 16 Jul 2021 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhGPQVC (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 16 Jul 2021 12:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGPQVB (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 16 Jul 2021 12:21:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EE0C06175F;
        Fri, 16 Jul 2021 09:18:06 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8-20020a17090a4888b02901725eedd346so7329962pjh.4;
        Fri, 16 Jul 2021 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=amX7qutlZhujxzkVI8h2MRjygSTlMU+z05sQsjTc09A=;
        b=Z6cx7oOfjGT/bqo9cOCBh4nVHwF7jXwmbr8Jj/+TlHpueGN904486L2JjfhzoKxAmV
         2n3W94KJi32sEwFcVXXBEY+GnSY7zya1JImCg6egRRFj2R6Ato5OqzTlbCLVwA4GEBWi
         BJbf06wb6v85bbHBefrWfcacWDjSbg1s6z85k/+kyODmbPTpzpJI9A/uWnEj48+P8XXQ
         9lKRcDvJtM1nKWfaX9PU4fWgz2yk9TZ5zCeXANTiPC/JR/02SA80S9HJqG4owN1JG1rV
         4CV4pglY8wKpmatjqvrnuhBNotSYH9VLrWkfRrh0nX8/UMM3MAUmuETNkG4Wh8mlPvbC
         EF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=amX7qutlZhujxzkVI8h2MRjygSTlMU+z05sQsjTc09A=;
        b=Rn6EO83YMZhqvdABHPz6GEHh+CcbBp9DiGm1fOAKoVAZTfn06RdyECHcQ57f10d6p4
         fP1fNhAB+c9LvJoOAmi1YzeVkEP5WWRcabRB8nc+cDChju2pxG7YqBelgDZiklWClxYO
         72iD44Dpm7gDYlm9/86gw9cZd/K7qmNs93kecmmteQfQa87NTIRoQCggmxeOsEK5TeQe
         +ymHXTqbdAyciJLcuzU4rbFu9EcGkKsg+tINVe4PRlzEpYxgs4RQRp5YbhRewoqDMfwb
         qZ5jyJgD67DxbO/FiczKKlbp0ea5ezY+EcGpLEPCjNKKJTtKUsxZQH3IwJWjtmwa9A9K
         HsWQ==
X-Gm-Message-State: AOAM531UnZxbk/jyT+wmVBTzWDvWQfnCAPBap7q/WHsoLnZwro71GRDp
        k8UssfsRmKaI/gQ1TNRpD+Y=
X-Google-Smtp-Source: ABdhPJwNMNaZivC0jD0LKy2ham09tnMr+DjbI3xgx8rQvzU92igxRtYns/xs0lrCZVQjC8pubno+rQ==
X-Received: by 2002:a17:90a:f3d2:: with SMTP id ha18mr16589828pjb.92.1626452285831;
        Fri, 16 Jul 2021 09:18:05 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:37b9])
        by smtp.gmail.com with ESMTPSA id 21sm10360295pfh.103.2021.07.16.09.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:18:05 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Jul 2021 06:18:01 -1000
From:   Tejun Heo <tj@kernel.org>
To:     zhaoxiaoqiang007@gmail.com
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        viro@zeniv.linux.org.uk, cgroups@vger.kernel.org,
        trivial@kernel.org, linux-kernel@vger.kernel.org,
        zhaoxiaoqiang11 <zhaoxiaoqiang11@jd.com>
Subject: Re: [PATCH] cgroup: remove cgroup_mount from comments
Message-ID: <YPGxObHzJFMeQZOn@mtj.duckdns.org>
References: <20210716091853.1049-1-zhaoxiaoqiang11@jd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716091853.1049-1-zhaoxiaoqiang11@jd.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jul 16, 2021 at 05:18:53PM +0800, zhaoxiaoqiang007@gmail.com wrote:
> From: zhaoxiaoqiang11 <zhaoxiaoqiang11@jd.com>
> 
> Git rid of the inappropriate comment
> 
> Since cgroup is fully switched to fs_context, function cgroup_mount
> is removed and it's confused to mention in comments of cgroup_kill_sb.
> Just wipe it out.
> 
> Signed-off-by: zhaoxiaoqiang11 <zhaoxiaoqiang11@jd.com>

Applied to cgroup/for-5.15 w/ some description tweaks.

Thanks.

-- 
tejun
