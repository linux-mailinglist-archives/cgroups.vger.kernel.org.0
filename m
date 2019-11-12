Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC20F94B6
	for <lists+cgroups@lfdr.de>; Tue, 12 Nov 2019 16:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfKLPvR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 12 Nov 2019 10:51:17 -0500
Received: from mail-qt1-f181.google.com ([209.85.160.181]:37690 "EHLO
        mail-qt1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfKLPvR (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 12 Nov 2019 10:51:17 -0500
Received: by mail-qt1-f181.google.com with SMTP id g50so20228914qtb.4;
        Tue, 12 Nov 2019 07:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rIVoNOz4T7j7fSaGQI1Ha0h4ohKX0AGKJfytZEHxESg=;
        b=ZNPttLUmJUEbIG2K/YbRhC/Z7rYwyz9P92jlUaFydZKGLbX6+HsM7LimBSZqqCYqhb
         pYlmXL/tMccVeT08++KILqaPrN2fJxvS+XEsi/RZSvJlJJDuYtsd8w8NjSWVexMJQJvr
         SCzmFhiXL6du2CYTWsOWOTRLaCvbr6P+n0W858JFXSF9iIVREf66fjuwFoTLvsBtX+81
         CcaSPZJ4VMhwhvR0DdywQnv1Ru5LW7BRRLbk0Qf+S33Nf6jBIx/p2xDtplYQKX0PxDO5
         wh6TW07Yjvs17D5M4Ab3OOLXWm7UnokqPlv0dYCPO4bVJMzkYQ05HJZ/OZ/+BReSS3t8
         xWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=rIVoNOz4T7j7fSaGQI1Ha0h4ohKX0AGKJfytZEHxESg=;
        b=VCEFZddlKA1J/aE8bNEmNtoxEma48GvmCyKDkD4tNNMscsQ1072acoNHFsuBphUaAu
         FV5FBnTWjFgfAbspA7b0roLT2BTjPTmvMC3VMbQVxGf+lQw6+tZyt1MfdIQuUb+fvg+W
         ai5+n5mXTnimyggC/v3NoEEjc+oBzuZ1A3AzCmMPYVZLspgZGqUdciAFEUl1SIujZwyY
         xOtzXiQrr9fAJzpK2tTAxmTWYXOvbYRH8qf5uiFEhNmj6ZwQf61J7Wt8zSoi3z4DZ1Mr
         dyoVR+YRbjsuSLOlaarJtBM5BlLoIhs/zMiA9ADDaJQRBrZtiQly+Xsvap7vRjWXzBUn
         wENg==
X-Gm-Message-State: APjAAAXTEaLB7dtnXkB1A9hbA729hCiwU0jqXxqLzrVcziooSlE1TOth
        vu6g+vgA6snJRGd/qus+DYA=
X-Google-Smtp-Source: APXvYqwFawfeWm6fRBnuZBGHaUnUoeXceuXbsribbvIXwB4WMdL8jLUfv7JHrluf25OhRAZinwumzg==
X-Received: by 2002:aed:34c6:: with SMTP id x64mr31848120qtd.324.1573573876017;
        Tue, 12 Nov 2019 07:51:16 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::3:f36a])
        by smtp.gmail.com with ESMTPSA id g45sm11316870qtb.48.2019.11.12.07.51.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 07:51:15 -0800 (PST)
Date:   Tue, 12 Nov 2019 07:51:14 -0800
From:   Tejun Heo <tj@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        namhyung@kernel.org, ast@kernel.org, daniel@iogearbox.net
Subject: Re: [PATCHSET cgroup/for-5.5] kernfs,cgroup: support 64bit inos and
 unify cgroup IDs
Message-ID: <20191112155114.GF4163745@devbig004.ftw2.facebook.com>
References: <20191104235944.3470866-1-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104235944.3470866-1-tj@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello, Greg.

A gentle ping.  I can route these through cgroup/for-5.5 if you're
okay with the patch series.

Thanks.

-- 
tejun
