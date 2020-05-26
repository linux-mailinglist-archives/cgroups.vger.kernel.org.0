Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AFA1E2878
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2020 19:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbgEZRUk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 May 2020 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388061AbgEZRUk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 May 2020 13:20:40 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C845C03E96D;
        Tue, 26 May 2020 10:20:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n11so15923758qkn.8;
        Tue, 26 May 2020 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5UGKXExeW+nhU16EFqfK9RzsDWq/8Qsk6MN8cmfOs4Q=;
        b=fXVsQMGLbf3AGbHuPnQtv+E7wUV4PZgjmSB3XiMW5ldzvsV92NRJW0zZtBOWLkeWxg
         itvONAkOSfEdL3l2EReMxObAhPx0DcObj7M8JTns9pgVP0V61MG3hM55v+dwzjjuMo01
         zalrBdHDedUYhutoQlCSWg1o4Wc4WAlZgmbmXVbkZXBA1ELtSJ45Y5u/0fctnVJam8NM
         IATgAm6VsAqHaPRC/MtWQTdDMcNPcDBMzHm7bfXZsW2IOHYLh4Dbu4bjtdYoEIXvjk9P
         4rlmEoAjHS9+4V6WynMOk5TqiUnjVSE14QWM/3stzi476R5dxuxz1XjoygTNE2vP/XWd
         3n8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5UGKXExeW+nhU16EFqfK9RzsDWq/8Qsk6MN8cmfOs4Q=;
        b=dNOLAawRMIi3zjcInzlAsmy+zQxvnkNBy/1ACkIHBjdH59kEu/53Xmt4Xu5t3CH0Ed
         BhhSUXYdf4uffmqnGppXzoa+jJoYy1uEEN9tfqqf2jn7MfEpMWlrGYBTqN/RO1sZLPs8
         lSfkwJzEl/2O+20g5o7Jl1IsLjbx3yXLhApwKi5c1o9qP+NCbaCzCmoCloryb7RfJ5aU
         DPiZx87CJfSw71RLUysIFhiFQWsJWMyAADyzb4HhG1oMydZ7fPPv9+K63fAZq/bPl8ok
         Q+moq4mBj8tkAv6dSo0GyEEqYU2raDaoGWF5Zy+RY3+zgp0XFfJL9evgauBKoCjWjhZG
         OFMg==
X-Gm-Message-State: AOAM530Q5NMVLKSe4M4JuhID+kMbNoj3Q+/6LbEMlGk31Cykyy1rRmmu
        vn2kOnBMLOk53dcY6WJBQthtdHs5
X-Google-Smtp-Source: ABdhPJysHKl3r5+RtXDnqyls0wrwrs5WQYYlIYzkgLgpTWiv6Y3X9QUSx3W/OHfGhuKm8e4cFj9JSw==
X-Received: by 2002:a05:620a:147:: with SMTP id e7mr2457674qkn.267.1590513639385;
        Tue, 26 May 2020 10:20:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:85c0])
        by smtp.gmail.com with ESMTPSA id g5sm229443qti.87.2020.05.26.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:20:38 -0700 (PDT)
Date:   Tue, 26 May 2020 13:20:37 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Zefan Li <lizefan@huawei.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: Remove stale comments
Message-ID: <20200526172037.GC83516@mtj.thefacebook.com>
References: <0ce73f20-6b19-38c7-81c5-b0b71013fcb7@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ce73f20-6b19-38c7-81c5-b0b71013fcb7@huawei.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, May 13, 2020 at 10:13:11AM +0800, Zefan Li wrote:
> - The default root is where we can create v2 cgroups.
> - The __DEVEL__sane_behavior mount option has been removed long long ago.
> 
> Signed-off-by: Li Zefan <lizefan@huawei.com>

Applied to cgroup/for-5.8.

Thanks.

-- 
tejun
