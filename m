Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4CC166C7E
	for <lists+cgroups@lfdr.de>; Fri, 21 Feb 2020 02:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729226AbgBUBxE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Feb 2020 20:53:04 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43734 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729045AbgBUBxE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Feb 2020 20:53:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so69302oif.10
        for <cgroups@vger.kernel.org>; Thu, 20 Feb 2020 17:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ed/ULQux6UGHmXOZ5IaN1TKuoav4MaQaUXExci3Yy7w=;
        b=fipejZ7K5WnG6SXrZ80ASoZ5TGGWl3vqTWYavMHSfZT7FhkAJuDP3Gec4Y8Tkc3kIq
         k+A+MtU9VEay6hpyl0nPlsALIfsWzjSJvl34jvi5nKYHrF3Likd8E1NzpI54bCq0hD13
         uZ2cVBG3xy/XXl4Zj6WnwhXA0K0RV3imaPJCS2huh9A2C7yAQVs5+Y0/7u/qzd89Drzu
         JdE6BgUkerPnKyyMLGbh0RnHJb/kOTgPmRfue4kT4IQ6owDzY4mXgTqtjrrj8ctMhc1L
         zjuAstA0xMpKN0ZnxRlpECVKfTbLlWKwoMOOfZWYGzEw33Z7AbtQ6oMixuUnYRC6Zxye
         iQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ed/ULQux6UGHmXOZ5IaN1TKuoav4MaQaUXExci3Yy7w=;
        b=FYpKcmKTxjgidnUA0shF8PN9ZPonVZdV15xYVSZSEOdYjdQ9DVozaWGcn0KPRUF/o1
         IJ56Lk9+c2Us0CQgH3fOnGpO/Hl4U+2EOIA05tH/P4eIfmt6TihqpNDuIptjdDvuiNOM
         fVNnFFkQ9N4CoX4uxf1G3ilwLCgwsCbvAnTtfdYFPJdySh7eNWJR3jWuBi7JD25vuuSj
         Gnp7evEKKa01bs5D25wku78jTUhX71HzARtqe8v1IQ9oWh/W0znoPMYIb6iVnSg5BYwy
         JEODAXqtVZrFUwW4KNN3uYNvQgJnCD9YGvVRmZHEF8MSp+h/CQz9qd1Z0Vo7hpvlHLiC
         4Nng==
X-Gm-Message-State: APjAAAVKJv2NvzQJ3+1wcQ6waNiXhxx5tKrh93pYwb8jvRDr54cuKswN
        6fI0Nf7PijXLOE7A/FoFXjX6l3uFzMt8Jlowi9emPw==
X-Google-Smtp-Source: APXvYqzPP8CwfNhvNCN6ImhUwktGGsfq3wy3xd04wzn27NwLa10gpu4eB4YRS8qbHOtGI0P5++1xMs1VCaKfkK4w0TQ=
X-Received: by 2002:a54:4086:: with SMTP id i6mr61878oii.65.1582249983496;
 Thu, 20 Feb 2020 17:53:03 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com>
 <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
 <CAHS8izN_FJektipBwiLsCO8ysMTM7k=CR_k3OV7+_y0ZbrGw+A@mail.gmail.com>
 <20200220162813.aea8a14fe050473b73440323@linux-foundation.org> <0cdd654b-a1f6-fea2-e448-209fbbe14b5c@oracle.com>
In-Reply-To: <0cdd654b-a1f6-fea2-e448-209fbbe14b5c@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 20 Feb 2020 17:52:52 -0800
Message-ID: <CAHS8izPZPDB=nK9Sm3znXxegSSr8Qf4NU5MiDcBb8EAF53LPLg@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        shuah <shuah@kernel.org>, David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 20, 2020 at 4:41 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/20/20 4:28 PM, Andrew Morton wrote:
> > It all looks pretty good and I expect we can get everything into
> > 5.7-rc1, unless some issues pop up.
> >

Awesome! I'll be on the lookout for issues.

Folks that reviewed (and especially Mike), thank you so much for the
patient reviews!

> > It's unclear to me whether
> > http://lkml.kernel.org/r/CAHS8izOTipknnYaKz=FdzL-7yW-Z61ck1yPnYWixyMSJuTUYLQ@mail.gmail.com
> > was going to result in an update?
>
> Yes there was,
>
> https://lore.kernel.org/linux-mm/20200219233610.13808-1-almasrymina@google.com/
>
> BTW, I've been through the selftest code at a high level.  Not at the level
> of detail Shuah may provide.  I am just happy that Mina provided a relatively
> comprehensive test for this new functionality.  Will give it an ACK shortly.
> --
> Mike Kravetz
