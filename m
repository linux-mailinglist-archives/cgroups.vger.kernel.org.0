Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6B22A0A1
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 23:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404251AbfEXVs7 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 17:48:59 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:39672 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbfEXVs7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 17:48:59 -0400
Received: by mail-vs1-f54.google.com with SMTP id m1so6855340vsr.6;
        Fri, 24 May 2019 14:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UJnJQ5bqtkhsbc5LmnjlhNy0KzxYLFVhiVDL893Qprg=;
        b=doT8/qzWqnbv2mkhBYFQIq7AdHTqOTSMiTuli8nrk3KNJiDdWQOXNbTj78tSlwJS7x
         14HZ9CsFxBt6TuKKFKTDsCPdnS8akeH8RAmbHFNeC4CXHxMIdmpxgmQXHZ8/7SsL1irI
         AXdOhMM7ZDWtfOqO2DmRgEl2CmyboKQmsj4nVq5KjHUYfeMEclI56l8mv7x7qJwbT7lh
         E+f8p01BzUiMWjgPlkFUSIONdmlbU4/Y7el/k6aAF4kY5OqlqzEdcYZgk/nJq8Ih/wmi
         7f0GMbXEXtl2gTkdflj8uCLNfp4kyKin4TJCXgnEtd9BLh17NSgsGMggDg0HVx0TNVbF
         QNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJnJQ5bqtkhsbc5LmnjlhNy0KzxYLFVhiVDL893Qprg=;
        b=jdJkpp8H9JXMTIi9ZPzwdQYLtED9n4sGiN/jJ4WLdt7XsWvWQSV+7MNoLTJH+RDgqZ
         CDf+ryfM/e1AQpjh+1F7JkdyXha3FqqD0Z/u1ZpdIw8S93A9YSBnmynXSMa6KDMFcr6p
         lhO8DG6D7mj5FNSyou+UvT1WeGnH0sKBnANPLDYolmE9OgtcuMna5MjnGWWbowY0/96P
         YBdOKGO/WOBrR9b4W5Eqk1OYyWLtWRXBU/vImvwuZ9uGp2l4PSZ8bIVjK6Yzu36sCAZG
         26vmFEZLWaLI+1SLVEW8Ig0LH/Nd0kPbiklz/owWou/qp/+6T7C6ANDxtq0PUBHDyqTd
         uAjg==
X-Gm-Message-State: APjAAAVqTf+2+QQnx07M0NxB8TXgRCnc1jEVQdasD+EBJ4n4lKBvm0Yc
        7HPnlVmxtB6FH/QKX4cZG8A=
X-Google-Smtp-Source: APXvYqxBj1kMexZ/pcXFq6Ft3JkiR/9Wnldj6W0LvyltgCQus7wq81jVOhaAmSbnswMfY6Vh9CHl7Q==
X-Received: by 2002:a67:bb1a:: with SMTP id m26mr49425913vsn.133.1558734538123;
        Fri, 24 May 2019 14:48:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:36ab])
        by smtp.gmail.com with ESMTPSA id n132sm3683220vke.18.2019.05.24.14.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:48:57 -0700 (PDT)
Date:   Fri, 24 May 2019 14:48:55 -0700
From:   Tejun Heo <tj@kernel.org>
To:     xxhdx1985126@gmail.com
Cc:     ceph-devel@vger.kernel.org, ukernel@gmail.com,
        cgroups@vger.kernel.org, Xuehan Xu <xuxuehan@360.cn>
Subject: Re: [PATCH] cgroup: add a new group controller for cephfs
Message-ID: <20190524214855.GJ374014@devbig004.ftw2.facebook.com>
References: <20190523064412.31498-1-xxhdx1985126@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523064412.31498-1-xxhdx1985126@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 23, 2019 at 06:44:12AM +0000, xxhdx1985126@gmail.com wrote:
> From: Xuehan Xu <xuxuehan@360.cn>
> 
> this controller is supposed to facilitate limiting
> the metadata ops or data ops issued to the underlying
> cluster.

Replied on the other post but I'm having a hard time seeing why this
is necessary.  Please explain in detail.

Thanks.

-- 
tejun
