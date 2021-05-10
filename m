Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 657123792E8
	for <lists+cgroups@lfdr.de>; Mon, 10 May 2021 17:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbhEJPkZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235000AbhEJPkN (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 11:40:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48684C06175F
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 08:39:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 558132B4;
        Mon, 10 May 2021 15:39:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 558132B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1620661143; bh=kAxTOos9FhekUtxqCg7hz6hwN4pulQIZ55PVCksaoi0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PTniAJrYlNDmkQ6f+1nDRzUQlwTUPhkx+L6/kP43U0/cGCzORYOmTAaQq3+UTpeqE
         D4uyD634BSuIgKb0ucUpW3hsX7XH4OL55XS2xzLD12p4UtA757JIhGNhm3/SMUytL8
         LiftNqplFiKPRxOaxcD8q1RJJtHZc8eOGBiRJyHmp/sULa5RTjpncocQgv9tJJxNy9
         23+b8XRuu0MabjyZzB8Zpsk61S7mw0Cjpksgy3yHScFfaFkz+3fD/eqbzGmsqXQQbE
         6WWAw9KTbxn+ljHG0MI6l7xKO5QB0rhM6rauBi8rf0+ss4P7tY7nGWfpCIXs85gF6H
         HJUE96da1+Mig==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Serge Hallyn <serge@hallyn.com>
Subject: Re: [PATCH v3 1/5] cgroup: introduce cgroup.kill
In-Reply-To: <20210508121542.1269256-1-brauner@kernel.org>
References: <20210508121542.1269256-1-brauner@kernel.org>
Date:   Mon, 10 May 2021 09:39:02 -0600
Message-ID: <874kfaha3t.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Christian Brauner <brauner@kernel.org> writes:

> Introduce the cgroup.kill file. It does what it says on the tin and
> allows a caller to kill a cgroup by writing "1" into cgroup.kill.
> The file is available in non-root cgroups.

So I feel like I'm missing something fundamental here...perhaps somebody
can supply a suitable cluebat.  It seems inevitable to me that, sooner
or later, somebody will surely wish that this mechanism could send a
signal other than SIGKILL, but this interface won't allow that.  Even if
you won't want to implement an arbitrary signal now, it seems like
defining the interface to require writing "9" rather than "1" would
avoid closing that option off in the future.

I assume there's some reason why you don't want to do that, but I'm to
slow to figure out what it is...?

Thanks,

jon
