Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F393537914E
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239112AbhEJOv4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 10:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:44746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236155AbhEJOum (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 10 May 2021 10:50:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DAE6613DE;
        Mon, 10 May 2021 14:49:34 +0000 (UTC)
Date:   Mon, 10 May 2021 16:49:32 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev, Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v3 1/5] cgroup: introduce cgroup.kill
Message-ID: <20210510144932.iv6gfc36ahkuihnz@wittgenstein>
References: <20210508121542.1269256-1-brauner@kernel.org>
 <YJlGSZlZYaaujm2O@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJlGSZlZYaaujm2O@slm.duckdns.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, May 10, 2021 at 10:42:17AM -0400, Tejun Heo wrote:
> Applied to cgroup/for-5.14.

Thanks!
Christian
