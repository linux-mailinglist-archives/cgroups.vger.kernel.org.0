Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8FE242141B
	for <lists+cgroups@lfdr.de>; Mon,  4 Oct 2021 18:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236945AbhJDQcO (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Oct 2021 12:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbhJDQcO (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 4 Oct 2021 12:32:14 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AE0C061745;
        Mon,  4 Oct 2021 09:30:25 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g2so14976048pfc.6;
        Mon, 04 Oct 2021 09:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U/gXY3WVhJ/nvDWWVPhBXPgTxuRKJcOBX7y2RATu4k8=;
        b=nR6cs3n/l5GebOuqrwwoUW8Dmv4Uc+aROASi3zE11rcVXU1dWmmNeMTupCOCJmZ2yg
         bCsK8eKbgKW+xIniwvS78xovucXVVspEDrSlHfqTN3OcVHUna5sWqwWnzIbiM4b1rFBd
         7Rt80oTFJzJOIJBTdNuy8ic4ni/iaUbFHiL8q65mBDms2v/sarrtifDmWD8cd35OgAUg
         dVHxcZs546XIATLMQPb2SlTihIkmqAdHoPAU0e41QEUZU5+IasQLSk1zSGY5gV0SLz+k
         f5btrkA1jNoEMq+Ot1Yb98AMq2fAP5uvZEQSYUHQ1lxAwONKJMf5Kazw2FTm+wJaKFyr
         k8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=U/gXY3WVhJ/nvDWWVPhBXPgTxuRKJcOBX7y2RATu4k8=;
        b=Ly9UQKrgm4zVP4HEw9fAkbXrfSLmbeah8DyZPg4fEwCVwnBhPzk0MMAD9unV1Qb3Fi
         p+h7WZzhKa4pote0qWsti6cliSRL2y6ZW59oJic7s1LL/JaCFo1gpdT7E2rodBxLEBYZ
         zNn2EUGRvlIHBhbx+5wMptpB6G/62zRp7HS/B29kfle/AO2y/3yqCBDq45ql51hnlYm/
         K+ysAGMOECELsboYWpIGGDax9qjEJF2x1xDSY61H/sl/vBsBriTJxHk8fDu9dbmg/rP5
         xB/vwKkXXSEj8fid40CV9irPUfmze0h1Oh/gVbQruj2/ERHscdwQeVan8TZ6BbWTz16w
         rYSQ==
X-Gm-Message-State: AOAM532UanYhp9hECJowoLWkZ6Fjt3QI/ZQjMZ0M9xyJ8QTXKfZpKd4x
        9p5EvvXxJLWNbggcjgT1cpw=
X-Google-Smtp-Source: ABdhPJxDG//5O1ZUGqvalSOL8+L5N2i7FGS/YP1KD4/omrYIHHLe0MI1C/FNW9fOgYi61oRH5MRViA==
X-Received: by 2002:a63:a65:: with SMTP id z37mr11909128pgk.192.1633365024435;
        Mon, 04 Oct 2021 09:30:24 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mj2sm386314pjb.18.2021.10.04.09.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:30:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 06:30:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] cgroup: a u16 is enough for cgroup_subsys.depends_on
Message-ID: <YVssHgmGdoSBY59K@slm.duckdns.org>
References: <20211004084928.17622-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004084928.17622-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 04, 2021 at 08:49:25AM +0000, Wei Yang wrote:
> After commit 6e5c830770f9 ("cgroup: make cgroup subsystem masks u16"),
> we limit the number of subsystem to be less then 16. This applies to
> cgroup_subsys.depends_on too.

None of the patches seems meaningful enough. I'm gonna ignore this series.

Thanks.

-- 
tejun
