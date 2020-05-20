Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B451DA749
	for <lists+cgroups@lfdr.de>; Wed, 20 May 2020 03:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgETBkd (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 19 May 2020 21:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBkd (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 19 May 2020 21:40:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC2FC061A0E
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 18:40:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so1745652lji.12
        for <cgroups@vger.kernel.org>; Tue, 19 May 2020 18:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AB3UrpKdSYqNoKld+7/yBXeix6D5EW8de7N53rttU58=;
        b=ZUbKC5RNgCvyOLKPhsbIJ57dk4je8Jxm8s6LskPkh9P6Xf0Gw5nSczmWdhwSu4jd27
         CwTWLhpkwuskeAVzCFYT9z1qB3DX9iXCCx2xazjxq9DBsjXCSbrBiUP5c9xBuRgw8KSt
         N/yUCpmbRIKBOsVPAIEBjZgL6DVOnCqsrspO3TSfpZEU32dF4FZv1GRdPw0C2bvIqonN
         jV3kRZrJoV+9+nIz9nbL8s8jvHGS3ZzZ2V1LuzGp0LDxKHGhXP+g6dzVa94utIFjlAxC
         V3ZXsHx4ZJWlmIJqT1gUZgQCnyi19eL65wL4H1n7HyQ48/X/m87Ko+zlz2hx/DOBfq2U
         Yu/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AB3UrpKdSYqNoKld+7/yBXeix6D5EW8de7N53rttU58=;
        b=MTRcDTCyywf1JwivUEtgCiqkvFabbKfapE5dhBhxqyX62MEYuDxJ15tUixwg2AEEaA
         zf4wxKdtehLt/6uT25UxzZjUvSr/BnqoMyw6we0RZdQ/Y0VzkfUJEDlgjPH+NV2IXVlU
         oQsWJRvUH5hMtjXXHEflemw7MOMWVxroJqh4jm/vzuVKz/3VzyypAf3vUB2bm1za/KZf
         UyDwEYiD87nqzTorvipuy8eYIAKJyGQyqBgJLzFeYoZ5+4/z1aH6NXYWx2kMyJRdamqV
         rDR91H4wCQD4wmP3LHSQmXWEKYHoJRV4IoYBvV31o0N6iKnJti+tsgaF423QwiUYNsA0
         bGWw==
X-Gm-Message-State: AOAM531B1VPWho7rYU3xZMxaLMYuzZU75brXL0yI5rsHbSftvIunyqOE
        Kd0g92i+Ap66+nHN0V6zKVRqUOMV1DvM8ADsCA8mDA==
X-Google-Smtp-Source: ABdhPJyvLgCFDA/IqogDBUlf43MU3doM5Wr1OEeOH0bkkBLF2lygfI3Dw4ijcIiB7f5LpwEVT4nKiZ+l+J+Xv46q5LU=
X-Received: by 2002:a2e:b0c8:: with SMTP id g8mr1233887ljl.270.1589938831022;
 Tue, 19 May 2020 18:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200519171938.3569605-1-kuba@kernel.org> <20200519171938.3569605-3-kuba@kernel.org>
In-Reply-To: <20200519171938.3569605-3-kuba@kernel.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 19 May 2020 18:40:19 -0700
Message-ID: <CALvZod7UNtiebGvsB6tPXCBPZ0vFjreJ7LwyM=D5LdFpAh9Jfg@mail.gmail.com>
Subject: Re: [PATCH mm v4 2/4] mm: move penalty delay clamping out of calculate_high_delay()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Chris Down <chris@chrisdown.name>,
        Cgroups <cgroups@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 19, 2020 at 10:19 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> We will want to call calculate_high_delay() twice - once for
> memory and once for swap, and we should apply the clamp value
> to sum of the penalties. Clamping has to be applied outside
> of calculate_high_delay().
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
