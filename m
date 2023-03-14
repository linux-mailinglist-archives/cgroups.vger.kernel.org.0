Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B356B8F3D
	for <lists+cgroups@lfdr.de>; Tue, 14 Mar 2023 11:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjCNKH6 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Mar 2023 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCNKHy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Mar 2023 06:07:54 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC88E3C1
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 03:07:53 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so8051104edd.5
        for <cgroups@vger.kernel.org>; Tue, 14 Mar 2023 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1678788471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ok3cioucmJfuqToGWB847OqBj7qCzxyQQ0EoG5bYZE4=;
        b=R37fmEuO0gMfIx7lcApi2XBVNccL81RrFPvxi9zi6GkpXFewb3tSL2AJQCIlrc7PWa
         Vbh6TX70ujrEhyBXTGjbJKDwjK2t/cpGPCyKWORm9vs2Y+t5HYGzsIJiWiUWjjXHah5i
         T4ZotFNP5ZbdIju97rz4G3JZlCrQJG9hHV87s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678788471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ok3cioucmJfuqToGWB847OqBj7qCzxyQQ0EoG5bYZE4=;
        b=mZwTwSO52vuI3bhmb+vFtHE/kVdCvfkN8q5L4loxul3R8luxxNMQX7kKwVPwjw5vwA
         K6q14jmq19A5DAwqqougX/ah53hwVqfjCT4dKtJqRGrreYN42EBNy3YsAzJWNdL7f/yt
         JNVWpPYnneC39ji419xJ7DwQ5ncp0Y2eQ7Nr8k12VbLz7sRfE7X8jLhKazE6BiGc/pH2
         fZuJrOUnN01Gy2khomUNIOSZ+U1HTMm6o0tQJxAMZO0U8Xwr5rsQgOd45fnlsxjk0QuB
         Fq+n76X1wv9I3tIxuzYvXJh6VUojAbHQFA8h9VlUfhJ0rGq/v/7+2OzMASRlBFEwrp8x
         /Kwg==
X-Gm-Message-State: AO0yUKV3dmcb2mj4MdOjSQOt4HbJ2uomxQeCBdR4IamnhwlwbIBX6FNQ
        I9dODo8WRBIGCl5SajorWYSHyFLhQb+BXxtynUuSiw==
X-Google-Smtp-Source: AK7set8NBHpNwg/0sOtBAbQGsX7I7F++lq6EwVRoz4lFkncOOKR4q+N8tV36Y55C0pzyxWd+1ICHRmlaGamuMoT7JHI=
X-Received: by 2002:a50:9314:0:b0:4fb:71d0:6aa8 with SMTP id
 m20-20020a509314000000b004fb71d06aa8mr4035898eda.0.1678788471328; Tue, 14 Mar
 2023 03:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <0f0e791b-8eb8-fbb2-ea94-837645037fae@kernel.dk>
In-Reply-To: <0f0e791b-8eb8-fbb2-ea94-837645037fae@kernel.dk>
From:   Daniel Dao <dqminh@cloudflare.com>
Date:   Tue, 14 Mar 2023 10:07:40 +0000
Message-ID: <CA+wXwBRGzfZB9tjKy5C2_pW1Z4yH2gNGxx79Fk-p3UsOWKGdqA@mail.gmail.com>
Subject: Re: [PATCH] io_uring/io-wq: stop setting PF_NO_SETAFFINITY on io-wq workers
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Mar 8, 2023 at 2:27=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> Every now and then reports come in that are puzzled on why changing
> affinity on the io-wq workers fails with EINVAL. This happens because the=
y
> set PF_NO_SETAFFINITY as part of their creation, as io-wq organizes
> workers into groups based on what CPU they are running on.
>
> However, this is purely an optimization and not a functional requirement.
> We can allow setting affinity, and just lazily update our worker to wqe
> mappings. If a given io-wq thread times out, it normally exits if there's
> no more work to do. The exception is if it's the last worker available.
> For the timeout case, check the affinity of the worker against group mask
> and exit even if it's the last worker. New workers should be created with
> the right mask and in the right location.

The patch resolved the bug around enabling cpuset for subtree_control for m=
e.
However, it also doesn't prevent user from setting cpuset value that
is incompatible
with iou threads. For example, on a 2-numa 4-cpu node, new iou-wrks are bou=
nd to
2-3 while we can set cpuset.cpus to 1-2 successfully. The end result
is a mix of cpu
distribution such as:

  pid 533's current affinity list: 1,2 # process
  pid 720's current affinity list: 1,2 # iou-wrk-533
  pid 5236's current affinity list: 2,3 # iou-wrk-533, running outside of c=
puset


IMO this violated the principle of cpuset and can be confusing for end user=
s.
I think I prefer Waiman's suggestion of allowing an implicit move to cpuset
when enabling cpuset with subtree_control but not explicit moves such as wh=
en
setting cpuset.cpus or writing the pids into cgroup.procs. It's easier to r=
eason
about and make the failure mode more explicit.

What do you think ?

Cheers,
Daniel.
