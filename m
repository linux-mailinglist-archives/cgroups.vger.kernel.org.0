Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79079451745
	for <lists+cgroups@lfdr.de>; Mon, 15 Nov 2021 23:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbhKOWQU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Nov 2021 17:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349123AbhKOWNM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Nov 2021 17:13:12 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A6AC03E00C;
        Mon, 15 Nov 2021 13:34:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id r132so13552394pgr.9;
        Mon, 15 Nov 2021 13:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vAeLeuKX9qzkFBsusVD2f4vveg/1KTUzCbxhrs8CM/4=;
        b=Fd7ClpIxpg8cp11Uf8eilB6WH6poftTDXKGP02+MkoM4XmqYtZUX4s4lxJUglLCSvk
         +Ku2zFyCfFmKbOlXK3eU4gcrdFDtNLFF94bChw0gh4j/Lq6DPqCn1nXt9+/0WS3FHHgT
         N7SymUa7BOx2GIf0j7B6G/smoCSgDZ9H5xLHEHl9or250PSJjGae3lFsUSxwELIb9/n5
         90XdvnHe7MhrVlxwuhpl1AwKN8Jobm36xLqchAQSBB20gz4tp7Ozv4wnsqiUOZl9bwVQ
         vHS+4PRUgP1ePVRESjj/6SqIHfF5qQ4TKxW8pNct7MfnQC9y/VA6W32T7TqiZbIMWEdh
         mJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=vAeLeuKX9qzkFBsusVD2f4vveg/1KTUzCbxhrs8CM/4=;
        b=FNhrD5vIh7Y452Oi7CwI6bj30Aigbn2rtOrX7f9R9ZcGHiBbWc+cKoF842KgymcQ3W
         skfXfEvBX6FFWq8WBvo5JFhyz4EKulzmFzd55EwWxVQ19/oLENWhrKiePDD7uJOQfG6o
         tlpsAlPVPeV++kZ+virfz5W/UXRtrtR9l5fK99tQX1k54BLrTEVJRa5afNL6i56wU6VL
         ybbbJ5O7+XedlDfCBX//wpWNd1cLn3J48o9SFhxw6OgDbL9D8z4gfOfPiGa4Xzm23+pd
         iP8pzTg81ZWU40BTboB1HKLSvy8rt6Xbcvzh+gmGbc8XPOsFuqHPu3e/LFcWTQ0+Gz+b
         nZYw==
X-Gm-Message-State: AOAM530chxbxYMv7JzcuZm9b2alLJZxPatka85NUBOgpUfKMuEzEkapJ
        oD64MmUGF2q4PSCHJ+zioJ0=
X-Google-Smtp-Source: ABdhPJyenBvJi22zZePaszAdHVpOPiyvW/o6yGlyTsRTaFSZnDYiGq+dt3HCgFzrGdNGqjgxoY3a7Q==
X-Received: by 2002:a05:6a00:1686:b0:44d:50e:de9e with SMTP id k6-20020a056a00168600b0044d050ede9emr36007725pfc.4.1637012093964;
        Mon, 15 Nov 2021 13:34:53 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id z10sm16555972pfh.106.2021.11.15.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 13:34:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 15 Nov 2021 11:34:52 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Hao Sun <sunhao.th@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: rstat: Mark benign data race to silence KCSAN
Message-ID: <YZLSfFVKVFqLj3sP@slm.duckdns.org>
References: <20211103165845.38226-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211103165845.38226-1-mkoutny@suse.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Nov 03, 2021 at 05:58:45PM +0100, Michal Koutný wrote:
> There is a race between updaters and flushers (flush can possibly miss
> the latest update(s)). This is expected as explained in
> cgroup_rstat_updated() comment, add also machine readable annotation so
> that KCSAN results aren't noisy.
> 
> Reported-by: Hao Sun <sunhao.th@gmail.com>
> Link: https://lore.kernel.org/r/CACkBjsbPVdkub=e-E-p1WBOLxS515ith-53SFdmFHWV_QMo40w@mail.gmail.com
> Suggested-by: Hao Sun <sunhao.th@gmail.com>
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>

Applied to cgroup/for-5.17.

Thanks.

-- 
tejun
