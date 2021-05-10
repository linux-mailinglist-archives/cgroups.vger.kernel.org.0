Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AC037924E
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 17:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbhEJPQ5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 11:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241592AbhEJPP7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 11:15:59 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF05C06123F
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 07:42:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id g17so8419202qvl.9
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 07:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=InhY7G+ybOozbNoTmfhu8yZlE9kzFAP76imGYr8FuFs=;
        b=jjdppZ0kKSgG+x06elMGfD3fyyCV6FSKvtXjK+rgq8/wbwL4h4NX9wsmFGIEFMT0FK
         4SBvK6JS07NIZcXf58zIP9G3mIDKuUL6NxklgUgvycAMT3NKmmmLtjwqjiQZ4gIVAVZj
         vRAHQQo64j6ewLFvXMtcUYVknfiwxo6kaCrJddfxmjt/NCOWNic6hPmIys+qGz0G1KV8
         fofE57P7aSNqU1vWEHIkXeueS7hxUUaZ+ifMsX9Xk3ccJ/3eC5HLk0+CCWdakczYTj6r
         S1HW/xoWxNABQ7AtNSceHhXR9YeCHpOlXO7QY6PfdNT0jyAEti3V3GgZwOPUp2JQaZek
         UesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=InhY7G+ybOozbNoTmfhu8yZlE9kzFAP76imGYr8FuFs=;
        b=Pzt4duhLBWB8oDZM8bUHtpSuHPfQTP6jhyrcwFfh+lxvsZny8YXllGHDaHyrqM6sQf
         4nT2HnnLURzvKXZDCO1E/Wt02kYQ+zKb1XY3lOTdWupVR8/r2y9EOmd1ZIpv+J1YmDDK
         L7txm+Jfl2nqoRINdh7sJyypjpWK5VehoVXOqe41++aCSxHo+6mw2pJhd3YSOBOjr7K9
         zTAWeKH812usjeD/U22+w/tTah/stAyKCJvc93BpqECkM2h0GtWDpz0yZ4ffUH1WMG8H
         lzxOGNVG2Xd5GageDwpE78REKxDSUWhvLIv8TUnFVfAGIABGy3zi14+XTDB7jv6coSxc
         5Yeg==
X-Gm-Message-State: AOAM530MOK4+b2ckj05ig3fTzsLWSj+U4xOUOnCm0yZQhgsyG4VNYVvQ
        mUtJTdG694fYc0ZaphWaOQg=
X-Google-Smtp-Source: ABdhPJyo0sICRY46JiwInz9mRIXGoQdUD1bcEQ238gnV4mkSakDM8KFkkC1rV8KurtigZBMnGkc1IQ==
X-Received: by 2002:a0c:fa8c:: with SMTP id o12mr23595836qvn.16.1620657739356;
        Mon, 10 May 2021 07:42:19 -0700 (PDT)
Received: from localhost (dhcp-6c-ae-f6-dc-d8-61.cpe.echoes.net. [199.96.183.179])
        by smtp.gmail.com with ESMTPSA id 25sm541511qky.16.2021.05.10.07.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 07:42:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 May 2021 10:42:17 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Roman Gushchin <guro@fb.com>, Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v3 1/5] cgroup: introduce cgroup.kill
Message-ID: <YJlGSZlZYaaujm2O@slm.duckdns.org>
References: <20210508121542.1269256-1-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508121542.1269256-1-brauner@kernel.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Applied to cgroup/for-5.14.

Thanks.

-- 
tejun
