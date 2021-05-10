Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69AC379994
	for <lists+cgroups@lfdr.de>; Tue, 11 May 2021 00:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhEJWEJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 May 2021 18:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbhEJWEJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 May 2021 18:04:09 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A16DEC061574
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 15:03:03 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e11so9126167ljn.13
        for <cgroups@vger.kernel.org>; Mon, 10 May 2021 15:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xEEZ8t7f0Q20wXtDGcovj3/jFYFaAmR7f82EcXq4W5E=;
        b=Hf/Y6EU13veGHo0Ee/3Us0ThFP69fYhIWpWPeEAEnFGaowsbpvX0f3mNwLvfKkh5Cd
         GyWiWrN6TuNOaqFOq+H8VApUy0CL3ov965gx81tmgJ1z/21CSMMHodjtmOrHfV5o5JkU
         jjgez6QzICn/DZqYB8VEg16OonQiMpXhqDNebyVd4weEOVG78LhqJNPVpoCD7XBYa+uA
         Jpj2GT7mcB5er8odCcjADqa/835doJ3jp2st3CCnPnoayDiuWi9WOoPBCy34PVIaSsGm
         5P0eyqCAcykTddALOI2aBXjXNB+FNrjk36Hqt2pZKoPvHVAozX6CDSXrrD8nHFMy3p7N
         hCLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xEEZ8t7f0Q20wXtDGcovj3/jFYFaAmR7f82EcXq4W5E=;
        b=auRwAhuXUWETmmVns8ua0RaqINoTyVvGLGgdDIgdEGcc85x1MqG9RbkFYVRpKzvxYe
         i5TzpibgqKX2ARQbawQhbtJxbKISD6+prggjuuy14bjlriRGeVdBBy5RLVQeAm7BHxpt
         k5lN6yj6v2CS85SIQvKKasaECoxd+N7Jki9OGEvkFfEjiCOtA3Cydbpgq8k8W1KTsQ7i
         C/OmfY7v2k9CGkxh7vNFWUg0smCcYQXKdUd4d2KAAOfDYZEpKyl67BMYLpwL5kGma/qO
         crTh+LUYwE6LkPzaUdQlNr8JXtS5sXx8TddaoJcapFyJNvIp/sE4F4RWYPMPtzMHAHDf
         GppQ==
X-Gm-Message-State: AOAM530cGJukTS9dsYK6+gtYcIYTJ43Oc8sHX114ooLv6qmt+rQsjP8L
        8PddADKzWoJ5CVA0ePeAnkJZyxfniSWsHJNZ6l/nIg==
X-Google-Smtp-Source: ABdhPJx+u9RuRo22VMZhaiasP1ubQyf0AjHX0Q/UuWEF7ZR+H9hQnDZNMOf/z3bR++hDwZPaaIkEX8R3q5b6IoYH5j8=
X-Received: by 2002:a05:651c:210f:: with SMTP id a15mr21026933ljq.160.1620684181812;
 Mon, 10 May 2021 15:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210508121542.1269256-1-brauner@kernel.org> <20210508121542.1269256-5-brauner@kernel.org>
In-Reply-To: <20210508121542.1269256-5-brauner@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 10 May 2021 15:02:51 -0700
Message-ID: <CALvZod4mOdiPzHzCi3LKoNheKY7j4rDfYipeuXQa7tCUpDi1cQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] tests/cgroup: test cgroup.kill
To:     Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Cgroups <cgroups@vger.kernel.org>, containers@lists.linux.dev,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, May 8, 2021 at 5:16 AM Christian Brauner <brauner@kernel.org> wrote:
>
> From: Christian Brauner <christian.brauner@ubuntu.com>
>
> Test that the new cgroup.kill feature works as intended.
>
> Link: https://lore.kernel.org/r/20210503143922.3093755-5-brauner@kernel.org
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: cgroups@vger.kernel.org
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
