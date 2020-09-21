Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D415E272915
	for <lists+cgroups@lfdr.de>; Mon, 21 Sep 2020 16:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgIUOuR (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Sep 2020 10:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgIUOuM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Sep 2020 10:50:12 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C96C061755;
        Mon, 21 Sep 2020 07:50:12 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id n10so12537170qtv.3;
        Mon, 21 Sep 2020 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I0TzWXUmgi2lOEHpdl5qmQ0obP+a5wT/52mUzrc/Cfw=;
        b=H4Yxk2SPjvLf2Brrla/hrvyq/OarS424J9FV8e1g25bELnn/LLXo44r2kzde5q0I7J
         mjKpYsrkCTWeDdh8qDWSf00x4bh8CXq+JPKScEkemo4j8xD+q4qfALCjyeqei3pKuLcm
         Bdr14uL8sNnC7bpzsT03ZCqVKKHeEsK0nTOUBKOKX+Xg+VQanXssvIv1+z4S+PxsIu8i
         mBxqLYlWeveKSKy74N3HJm/uDVIk+VyzU1dNJ0wKA1Kvz25vFyh8iu/SfcMVxF+GxRyn
         +0e8YMKCH/andqHfGTX8pEbimG8cSXJhvLiPuWljEK+LItU0WODLZNcFyUswDl+W+6XG
         i8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=I0TzWXUmgi2lOEHpdl5qmQ0obP+a5wT/52mUzrc/Cfw=;
        b=N9XDpQkw4VdJTEWb12dGJKv23ybRbpY1XRUOQ4xwtkJwARF6E0MgXcTgII0t9MpZM+
         G+xSRnEev5fO/E6Ym4R+hnvARPIUl6BwB1E1z5gPUO9ZOfJd+1Us38BSfPk7zaZ1gGEV
         IuAQcVbHYwkw5Dt8Cyfii5p6/96M473cHIVDlQgSTMe+1x/qnfJU96OMlhMHym/LIriu
         KDZ5lUs4T6sT9+aShNln9aImNFd1YA888776fC810v1fXK/4yPa5qX5Qioo/CggznhSG
         AXmFVZ4XDe3gVYxiH7JJvWd501790NDYUZDlLi+DJXSML1CLGvey4l7oM24Di2chSw7k
         XRVQ==
X-Gm-Message-State: AOAM531uzy28pnT/ZTtvivThq0hF/W1Cx27vT86jVH9hq24y8S7uPRH8
        aZOBErZ7bg6dC2capoWKTOM=
X-Google-Smtp-Source: ABdhPJzNNwPI/wJ/7TcWjcBWmRzVQTi9xiWSzOdY27OrIajjhpASkSL5yIN4toFKxhCtgEo3lO+psw==
X-Received: by 2002:ac8:71c6:: with SMTP id i6mr32876446qtp.318.1600699811627;
        Mon, 21 Sep 2020 07:50:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:54a6])
        by smtp.gmail.com with ESMTPSA id w36sm10370728qtc.48.2020.09.21.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 07:50:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 21 Sep 2020 10:50:09 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, corbet@lwn.net,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, luodaowen.backend@bytedance.com,
        songmuchun@bytedance.com
Subject: Re: [PATCH] cgroup: Add cgroupstats numbers to cgroup.stat file
Message-ID: <20200921145009.GD4268@mtj.duckdns.org>
References: <20200915155349.15181-1-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915155349.15181-1-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Tue, Sep 15, 2020 at 11:53:49PM +0800, Chengming Zhou wrote:
> In the cgroup v1, we can use netlink interface to get cgroupstats for
> a cgroup. But it has been excluded from cgroup v2 interface intentionally
> due to the duplication and inconsistencies with other statistics.
> To make container monitor tool like "cadvisor" continue to work, we add
> these cgroupstats numbers to the cgroup.stat file, and change the
> admin-guide doc accordingly.

So, we can't add O(nr_threads) operations to cgroup.stat reads. There are
two ways forward that I can see.

* Investigate how these counters are being used. If it's used for congestion
  detection, pressure metrics are likely better indicators to use anyway. If
  the usage frequency is low enough, maybe querying from userspace should
  work?

* If the need for these per-cgroup task state counters is really
  justifiable, the counters should be maintained from scheduling event
  directly and summed up using rstat like other statistics.

Thanks.

-- 
tejun
